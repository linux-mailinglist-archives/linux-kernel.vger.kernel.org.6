Return-Path: <linux-kernel+bounces-370127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DB49A2809
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F631F24788
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7A21DF27D;
	Thu, 17 Oct 2024 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="WY1TIjhn"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05661DF247;
	Thu, 17 Oct 2024 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181377; cv=none; b=BQnonwS72a3/1TovT3zyUfjXpdbaNDVjn8yoSRep20fDiPO4BUhpXz4+6mVKxmH+qshwFC5IPsw4va0GuAyXAnwegNFd4LrST1HCQbkXmkK0ajZ1j3EbTM85PzOZwcBSqbCIwZdJn6bb+p5TGgMkSlrUrtq/A6a5uDW/pJzgS9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181377; c=relaxed/simple;
	bh=rk1i/ow7W3Yo9mcje3vbCRzdvYIIPBGrq8ABT4GheJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dv5iaURQ3cek5KOe1Zc5Yludzz+611FG098I1qzS7pqJJSjmBGY/8s62Cxb1moo0DuGEWiGKUTNL2/ugD57rV+2ZDyY2F9Au4hzdg8otSVFknjMjdAra38OrcFg2NUMMHdLAW+U4SGvVbJfEY8iSGA2Yfs8QQtH2g+N2DzkBH50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=WY1TIjhn; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CA21A42B29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729181372; bh=pHeaxIm6DMW2HYoCYMMOnsEL7M+CZsPpC/JgSlxTHYY=;
	h=From:To:Cc:Subject:Date:From;
	b=WY1TIjhniLb/AJWcguLAErOFYKP1I17bza3aWsXv9rG+dISnSP0uUdfkBNXnNNPE5
	 rqiJMXg4JYpeP5NP0ePsDBp9ehCE8apuNf+IABYMAnvifyfamJQD/lF1gFqv8uvder
	 vXCPTbU5fuRfe8OwYhLUl8E4n1jv2knY2rD//HSewJuJ62K92ftNLQpprVCIbpFPNc
	 3W8TPi+ZFXPrmbmlCDpbezjG4JTNdsrhOEECIJwme6E4itIWc7lLYVY5Jiv8Z/r4T7
	 iLdGKxdRtS4pLHXobKMLAZLf8NBUjfDcSNNay+2muwIBHBH4+WavXLq7edf8MWLRvz
	 J89+8wXJQl/ZA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CA21A42B29;
	Thu, 17 Oct 2024 16:09:31 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: Federico Vaga <federico.vaga@vaga.pv.it>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <si.yanteng@linux.dev>, Hu Haowen
 <2023002089@link.tyut.edu.cn>, Akira Yokosawa <akiyks@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH] docs: remove Documentation/dontdiff
Date: Thu, 17 Oct 2024 10:09:31 -0600
Message-ID: <87y12m1zk4.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The dontdiff file is a relic from the pre-Git era that has little use now.
It has entries (parse.c, for example) that will mask real changes to kernel
source files.  There are all kinds of entries for files we do not create
anymore.  Rather than try to fix it up, simply remove it.

Update the kernel documentation (and translations) to remove references to
this file.  There is an ancient Japanese translation of SubmittingPatches
that I am unable to update; that really needs a thorough redo.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/dontdiff                        | 271 ------------------
 Documentation/process/5.Posting.rst           |   5 -
 .../translations/it_IT/process/5.Posting.rst  |   5 -
 .../translations/zh_CN/process/5.Posting.rst  |   4 -
 .../translations/zh_TW/process/5.Posting.rst  |   4 -
 5 files changed, 289 deletions(-)
 delete mode 100644 Documentation/dontdiff

diff --git a/Documentation/dontdiff b/Documentation/dontdiff
deleted file mode 100644
index de2cb8de6112..000000000000
--- a/Documentation/dontdiff
+++ /dev/null
@@ -1,271 +0,0 @@
-*.a
-*.aux
-*.bc
-*.bin
-*.bz2
-*.c.[012]*.*
-*.cis
-*.cpio
-*.csp
-*.dsp
-*.dvi
-*.elf
-*.eps
-*.fw
-*.gcno
-*.gcov
-*.gen.S
-*.gif
-*.grep
-*.grp
-*.gz
-*.html
-*.i
-*.jpeg
-*.ko
-*.ll
-*.log
-*.lst
-*.lzma
-*.lzo
-*.mo
-*.moc
-*.mod
-*.mod.c
-*.o
-*.o.*
-*.order
-*.orig
-*.out
-*.patch
-*.pdf
-*.plist
-*.png
-*.pot
-*.ps
-*.rej
-*.s
-*.sgml
-*.so
-*.so.dbg
-*.symtypes
-*.tab.c
-*.tab.h
-*.tex
-*.ver
-*.xml
-*.xz
-*.zst
-*_MODULES
-*_vga16.c
-*~
-\#*#
-*.9
-.*
-.*.d
-.mm
-53c700_d.h
-CVS
-ChangeSet
-GPATH
-GRTAGS
-GSYMS
-GTAGS
-Image
-Module.markers
-Module.symvers
-PENDING
-SCCS
-System.map*
-TAGS
-aconf
-af_names.h
-aic7*reg.h*
-aic7*reg_print.c*
-aic7*seq.h*
-aicasm
-aicdb.h*
-altivec*.c
-asm-offsets.h
-asm_offsets.h
-autoconf.h*
-av_permissions.h
-bbootsect
-binkernel.spec
-bootsect
-bounds.h
-bsetup
-btfixupprep
-build
-bvmlinux
-bzImage*
-capability_names.h
-capflags.c
-classlist.h*
-comp*.log
-compile.h*
-conf
-config
-config-*
-config.mak
-config.mak.autogen
-conmakehash
-consolemap_deftbl.c*
-cpustr.h
-crc32table.h*
-cscope.*
-defkeymap.c
-devlist.h*
-devicetable-offsets.h
-dnotify_test
-dslm
-dtc
-elf2ecoff
-elfconfig.h*
-evergreen_reg_safe.h
-fixdep
-flask.h
-fore200e_mkfirm
-fore200e_pca_fw.c*
-gconf
-gconf-cfg
-gen-devlist
-gen_crc32table
-gen_init_cpio
-generated
-genheaders
-genksyms
-*_gray256.c
-hpet_example
-hugepage-mmap
-hugepage-shm
-ihex2fw
-inat-tables.c
-initramfs_list
-int16.c
-int1.c
-int2.c
-int32.c
-int4.c
-int8.c
-kallsyms
-keywords.c
-ksym.c*
-ksym.h*
-*lex.c
-*lex.*.c
-linux
-logo_*.c
-logo_*_clut224.c
-logo_*_mono.c
-mach-types
-mach-types.h
-machtypes.h
-map
-map_hugetlb
-mconf
-mconf-cfg
-miboot*
-mk_elfconfig
-mkboot
-mkbugboot
-mkcpustr
-mkdep
-mkprep
-mkregtable
-mktables
-mktree
-mkutf8data
-modpost
-modules-only.symvers
-modules.builtin
-modules.builtin.modinfo
-modules.builtin.ranges
-modules.nsdeps
-modules.order
-modversions.h*
-nconf
-nconf-cfg
-ncscope.*
-offset.h
-oui.c*
-page-types
-parse.c
-parse.h
-patches*
-pca200e.bin
-pca200e_ecd.bin2
-perf.data
-perf.data.old
-perf-archive
-piggyback
-piggy.gzip
-piggy.S
-pnmtologo
-ppc_defs.h*
-pss_boot.h
-qconf
-qconf-cfg
-r100_reg_safe.h
-r200_reg_safe.h
-r300_reg_safe.h
-r420_reg_safe.h
-r600_reg_safe.h
-randstruct.seed
-randomize_layout_hash.h
-randomize_layout_seed.h
-recordmcount
-relocs
-rlim_names.h
-rn50_reg_safe.h
-rs600_reg_safe.h
-rv515_reg_safe.h
-series
-setup
-setup.bin
-setup.elf
-sortextable
-sImage
-sm_tbl*
-split-include
-syscalltab.h
-tables.c
-tags
-test_get_len
-tftpboot.img
-timeconst.h
-times.h*
-trix_boot.h
-utsrelease.h*
-vdso-syms.lds
-vdso.lds
-vdso32-int80-syms.lds
-vdso32-syms.lds
-vdso32-syscall-syms.lds
-vdso32-sysenter-syms.lds
-vdso32.lds
-vdso32.so.dbg
-vdso64.lds
-vdso64.so.dbg
-version.h*
-vmImage
-vmlinux
-vmlinux-*
-vmlinux.aout
-vmlinux.bin.all
-vmlinux.lds
-vmlinux.map
-vmlinux.symvers
-vmlinuz
-voffset.h
-vsyscall.lds
-vsyscall_32.lds
-wanxlfw.inc
-uImage
-unifdef
-utf8data.c
-wakeup.bin
-wakeup.elf
-wakeup.lds
-zImage*
-zoffset.h
diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.=
Posting.rst
index de4edd42d5c0..b3eff03ea249 100644
--- a/Documentation/process/5.Posting.rst
+++ b/Documentation/process/5.Posting.rst
@@ -191,11 +191,6 @@ change to a revision control system.  It will be follo=
wed by:
    option to diff will associate function names with changes, making the
    resulting patch easier for others to read.
=20
-You should avoid including changes to irrelevant files (those generated by
-the build process, for example, or editor backup files) in the patch.  The
-file "dontdiff" in the Documentation directory can help in this regard;
-pass it to diff with the "-X" option.
-
 The tags already briefly mentioned above are used to provide insights how
 the patch came into being. They are described in detail in the
 :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
diff --git a/Documentation/translations/it_IT/process/5.Posting.rst b/Docum=
entation/translations/it_IT/process/5.Posting.rst
index a61d9e6f7433..3b9b4db6fb9a 100644
--- a/Documentation/translations/it_IT/process/5.Posting.rst
+++ b/Documentation/translations/it_IT/process/5.Posting.rst
@@ -208,11 +208,6 @@ di commit in un sistema di controllo di versione.  Sar=
=C3=A0 seguito da:
    l'opzione "-p" assocer=C3=A0 alla modifica il nome della funzione alla =
quale
    si riferisce, rendendo il risultato pi=C3=B9 facile da leggere per gli =
altri.
=20
-Dovreste evitare di includere nelle patch delle modifiche per file
-irrilevanti (quelli generati dal processo di generazione, per esempio, o i=
 file
-di backup del vostro editor).  Il file "dontdiff" nella cartella Documenta=
tion
-potr=C3=A0 esservi d'aiuto su questo punto; passatelo a diff con l'opzione=
 "-X".
-
 Le etichette sopracitate danno un'idea di come una patch prende vita e sono
 descritte nel dettaglio nel documento
 :ref:`Documentation/translations/it_IT/process/submitting-patches.rst <it_=
submittingpatches>`.
diff --git a/Documentation/translations/zh_CN/process/5.Posting.rst b/Docum=
entation/translations/zh_CN/process/5.Posting.rst
index 6a469e1c7deb..6c83a8f40310 100644
--- a/Documentation/translations/zh_CN/process/5.Posting.rst
+++ b/Documentation/translations/zh_CN/process/5.Posting.rst
@@ -146,10 +146,6 @@
  - =E8=A1=A5=E4=B8=81=E6=9C=AC=E8=BA=AB=EF=BC=8C=E9=87=87=E7=94=A8=E7=BB=
=9F=E4=B8=80=E7=9A=84=EF=BC=88=E2=80=9C-u=E2=80=9D=EF=BC=89=E8=A1=A5=E4=B8=
=81=E6=A0=BC=E5=BC=8F=E3=80=82=E4=BD=BF=E7=94=A8=E2=80=9C-p=E2=80=9D=E9=80=
=89=E9=A1=B9=E6=9D=A5diff=E5=B0=86=E4=BD=BF=E5=87=BD=E6=95=B0=E5=90=8D=E4=
=B8=8E
    =E6=9B=B4=E6=94=B9=E7=9B=B8=E5=85=B3=E8=81=94=EF=BC=8C=E4=BB=8E=E8=80=
=8C=E4=BD=BF=E7=BB=93=E6=9E=9C=E8=A1=A5=E4=B8=81=E6=9B=B4=E5=AE=B9=E6=98=93=
=E8=A2=AB=E5=85=B6=E4=BB=96=E4=BA=BA=E8=AF=BB=E5=8F=96=E3=80=82
=20
-=E6=82=A8=E5=BA=94=E8=AF=A5=E9=81=BF=E5=85=8D=E5=9C=A8=E8=A1=A5=E4=B8=81=
=E4=B8=AD=E5=8C=85=E6=8B=AC=E4=B8=8E=E6=9B=B4=E6=94=B9=E4=B8=8D=E7=9B=B8=E5=
=85=B3=E6=96=87=E4=BB=B6=EF=BC=88=E4=BE=8B=E5=A6=82=EF=BC=8C=E6=9E=84=E5=BB=
=BA=E8=BF=87=E7=A8=8B=E7=94=9F=E6=88=90=E7=9A=84=E6=96=87=E4=BB=B6=E6=88=96=
=E7=BC=96=E8=BE=91=E5=99=A8
-=E5=A4=87=E4=BB=BD=E6=96=87=E4=BB=B6=EF=BC=89=E3=80=82=E6=96=87=E6=A1=A3=
=E7=9B=AE=E5=BD=95=E4=B8=AD=E7=9A=84=E2=80=9Cdontdiff=E2=80=9D=E6=96=87=E4=
=BB=B6=E5=9C=A8=E8=BF=99=E6=96=B9=E9=9D=A2=E6=9C=89=E5=B8=AE=E5=8A=A9=EF=BC=
=9B=E4=BD=BF=E7=94=A8=E2=80=9C-X=E2=80=9D=E9=80=89=E9=A1=B9=E5=B0=86
-=E5=85=B6=E4=BC=A0=E9=80=92=E7=BB=99diff=E3=80=82
-
 =E4=B8=8A=E9=9D=A2=E6=8F=90=E5=88=B0=E7=9A=84=E6=A0=87=E7=AD=BE=EF=BC=88ta=
g=EF=BC=89=E7=94=A8=E4=BA=8E=E6=8F=8F=E8=BF=B0=E5=90=84=E7=A7=8D=E5=BC=80=
=E5=8F=91=E4=BA=BA=E5=91=98=E5=A6=82=E4=BD=95=E4=B8=8E=E8=BF=99=E4=B8=AA=E8=
=A1=A5=E4=B8=81=E7=9A=84=E5=BC=80=E5=8F=91=E7=9B=B8=E5=85=B3=E8=81=94=E3=80=
=82
 :ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_=
submittingpatches>`
 =E6=96=87=E6=A1=A3=E4=B8=AD=E5=AF=B9=E5=AE=83=E4=BB=AC=E8=BF=9B=E8=A1=8C=
=E4=BA=86=E8=AF=A6=E7=BB=86=E6=8F=8F=E8=BF=B0=EF=BC=9B=E4=B8=8B=E9=9D=A2=E6=
=98=AF=E4=B8=80=E4=B8=AA=E7=AE=80=E7=9F=AD=E7=9A=84=E6=80=BB=E7=BB=93=E3=80=
=82=E6=AF=8F=E4=B8=80=E8=A1=8C=E7=9A=84=E6=A0=BC=E5=BC=8F=E5=A6=82=E4=B8=8B=
=EF=BC=9A
diff --git a/Documentation/translations/zh_TW/process/5.Posting.rst b/Docum=
entation/translations/zh_TW/process/5.Posting.rst
index 7d66a1c638be..38f3a6d618eb 100644
--- a/Documentation/translations/zh_TW/process/5.Posting.rst
+++ b/Documentation/translations/zh_TW/process/5.Posting.rst
@@ -149,10 +149,6 @@
  - =E8=A3=9C=E4=B8=81=E6=9C=AC=E8=BA=AB=EF=BC=8C=E6=8E=A1=E7=94=A8=E7=B5=
=B1=E4=B8=80=E7=9A=84=EF=BC=88=E2=80=9C-u=E2=80=9D=EF=BC=89=E8=A3=9C=E4=B8=
=81=E6=A0=BC=E5=BC=8F=E3=80=82=E4=BD=BF=E7=94=A8=E2=80=9C-p=E2=80=9D=E9=81=
=B8=E9=A0=85=E4=BE=86diff=E5=B0=87=E4=BD=BF=E5=87=BD=E6=95=B8=E5=90=8D=E8=
=88=87
    =E6=9B=B4=E6=94=B9=E7=9B=B8=E9=97=9C=E8=81=AF=EF=BC=8C=E5=BE=9E=E8=80=
=8C=E4=BD=BF=E7=B5=90=E6=9E=9C=E8=A3=9C=E4=B8=81=E6=9B=B4=E5=AE=B9=E6=98=93=
=E8=A2=AB=E5=85=B6=E4=BB=96=E4=BA=BA=E8=AE=80=E5=8F=96=E3=80=82
=20
-=E6=82=A8=E6=87=89=E8=A9=B2=E9=81=BF=E5=85=8D=E5=9C=A8=E8=A3=9C=E4=B8=81=
=E4=B8=AD=E5=8C=85=E6=8B=AC=E8=88=87=E6=9B=B4=E6=94=B9=E4=B8=8D=E7=9B=B8=E9=
=97=9C=E6=96=87=E4=BB=B6=EF=BC=88=E4=BE=8B=E5=A6=82=EF=BC=8C=E6=A7=8B=E5=BB=
=BA=E9=81=8E=E7=A8=8B=E7=94=9F=E6=88=90=E7=9A=84=E6=96=87=E4=BB=B6=E6=88=96=
=E7=B7=A8=E8=BC=AF=E5=99=A8
-=E5=82=99=E4=BB=BD=E6=96=87=E4=BB=B6=EF=BC=89=E3=80=82=E6=96=87=E6=AA=94=
=E7=9B=AE=E9=8C=84=E4=B8=AD=E7=9A=84=E2=80=9Cdontdiff=E2=80=9D=E6=96=87=E4=
=BB=B6=E5=9C=A8=E9=80=99=E6=96=B9=E9=9D=A2=E6=9C=89=E5=B9=AB=E5=8A=A9=EF=BC=
=9B=E4=BD=BF=E7=94=A8=E2=80=9C-X=E2=80=9D=E9=81=B8=E9=A0=85=E5=B0=87
-=E5=85=B6=E5=82=B3=E9=81=9E=E7=B5=A6diff=E3=80=82
-
 =E4=B8=8A=E9=9D=A2=E6=8F=90=E5=88=B0=E7=9A=84=E6=A8=99=E7=B1=A4=EF=BC=88ta=
g=EF=BC=89=E7=94=A8=E6=96=BC=E6=8F=8F=E8=BF=B0=E5=90=84=E7=A8=AE=E9=96=8B=
=E7=99=BC=E4=BA=BA=E5=93=A1=E5=A6=82=E4=BD=95=E8=88=87=E9=80=99=E5=80=8B=E8=
=A3=9C=E4=B8=81=E7=9A=84=E9=96=8B=E7=99=BC=E7=9B=B8=E9=97=9C=E8=81=AF=E3=80=
=82
 :ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <tw_=
submittingpatches>`
 =E6=96=87=E6=AA=94=E4=B8=AD=E5=B0=8D=E5=AE=83=E5=80=91=E9=80=B2=E8=A1=8C=
=E4=BA=86=E8=A9=B3=E7=B4=B0=E6=8F=8F=E8=BF=B0=EF=BC=9B=E4=B8=8B=E9=9D=A2=E6=
=98=AF=E4=B8=80=E5=80=8B=E7=B0=A1=E7=9F=AD=E7=9A=84=E7=B8=BD=E7=B5=90=E3=80=
=82=E6=AF=8F=E4=B8=80=E8=A1=8C=E7=9A=84=E6=A0=BC=E5=BC=8F=E5=A6=82=E4=B8=8B=
=EF=BC=9A
--=20
2.47.0


