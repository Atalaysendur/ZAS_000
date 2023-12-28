*&---------------------------------------------------------------------*
*& Report ZAS_P_LOCKPROCESS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zas_000_p_lockprocess.



SELECTION-SCREEN BEGIN OF BLOCK blk1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_rad1 RADIOBUTTON GROUP 1 DEFAULT 'X' USER-COMMAND radio .
  PARAMETERS: p_rad2 RADIOBUTTON GROUP 1.
  PARAMETERS: P_vbeln TYPE vbak-vbeln MODIF ID abc.
SELECTION-SCREEN END OF BLOCK blk1.

AT SELECTION-SCREEN .

  IF p_rad1 EQ 'X'.

    CALL FUNCTION 'ENQUEUE_EVVBAKE'
      EXPORTING
        mode_vbak      = 'E'
        mandt          = sy-mandt
        vbeln          = P_vbeln
        x_vbeln        = ' '
        _scope         = '2'
        _wait          = ' '
        _collect       = ' '
      EXCEPTIONS
        foreign_lock   = 1
        system_failure = 2
        OTHERS         = 3.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

    MESSAGE 'Locklama İşlemi Başarıyla Gerçekleşti' TYPE 'I'.

  ELSEIF p_rad2 EQ 'X'.

    CALL FUNCTION 'DEQUEUE_EVVBAKE'
      EXPORTING
        mode_vbak = 'E'
        mandt     = sy-mandt
        vbeln     = P_vbeln
        x_vbeln   = ' '
        _scope    = '3'
        _synchron = ' '
        _collect  = ' '.


    MESSAGE 'Locklama İşlemi İptal Edildi.' TYPE 'I'.

  ENDIF.
START-OF-SELECTION.
