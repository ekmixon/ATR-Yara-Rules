import "pe"

rule LockerGogaRansomware {
   
   meta:

      description = "LockerGoga Ransomware"
      author = "Christiaan Beek - McAfee ATR team"
      date = "2019-03-20"
      hash1 = "88d149f3e47dc337695d76da52b25660e3a454768af0d7e59c913995af496a0f"
      hash2 = "c97d9bbc80b573bdeeda3812f4d00e5183493dd0d5805e2508728f65977dda15"
      hash3 = "ba15c27f26265f4b063b65654e9d7c248d0d651919fafb68cb4765d1e057f93f"

   strings:

      $1 = "boost::interprocess::spin_recursive_mutex recursive lock overflow" fullword ascii
      $2 = ".?AU?$error_info_injector@Usync_queue_is_closed@concurrent@boost@@@exception_detail@boost@@" fullword ascii
      $3 = ".?AV?$CipherModeFinalTemplate_CipherHolder@V?$BlockCipherFinal@$00VDec@RC6@CryptoPP@@@CryptoPP@@VCBC_Decryption@2@@CryptoPP@@" fullword ascii
      $4 = "?http://crl.usertrust.com/USERTrustRSACertificationAuthority.crl0v" fullword ascii
      $5 = "cipher.exe" fullword ascii
      $6 = ".?AU?$placement_destroy@Utrace_queue@@@ipcdetail@interprocess@boost@@" fullword ascii
      $7 = "3http://crt.usertrust.com/USERTrustRSAAddTrustCA.crt0%" fullword ascii
      $8 = "CreateProcess failed" fullword ascii
      $9 = "boost::dll::shared_library::load() failed" fullword ascii
      $op1 = { 8b df 83 cb 0f 81 fb ff ff ff 7f 76 07 bb ff ff }
      $op2 = { 8b df 83 cb 0f 81 fb ff ff ff 7f 76 07 bb ff ff }

   condition:

      ( uint16(0) == 0x5a4d and filesize < 2000KB and ( 6 of them ) and all of ($op*)) or ( all of them )
}
