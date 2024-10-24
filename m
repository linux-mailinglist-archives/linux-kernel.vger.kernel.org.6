Return-Path: <linux-kernel+bounces-380742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C6E9AF571
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B541F216DD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19E62170DA;
	Thu, 24 Oct 2024 22:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cantab.net header.i=@cantab.net header.b="dYnzxSgB"
Received: from mta01.prd.rdg.aluminati.org (mta01.prd.rdg.aluminati.org [94.76.243.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4DB18784C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.76.243.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729809100; cv=none; b=Qnr6nr+S4LQ+JuZ9vAGQvGbe/dvCjSD3PABnb4OuihZ1tOqb+rxun4o3qRdFfoIMeOasV1TXv7/j0UBHuLQ05y4wh6uRDX8otokG1QFFVZFxyJvhR7QKUkUcb8i+yA8+zITuqVgsXZvRfAnLa6cR5QHsvrIvL3BDlQpaq9K5iyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729809100; c=relaxed/simple;
	bh=qqIJlHei51+mon1RXHylAf1fEh2i+ZRxxzyhDDTW4Ys=;
	h=From:Subject:To:Cc:Message-ID:Date:MIME-Version:Content-Type; b=bppEUD28J1DEix2IeZji+SG6Q9dTfVhCOXcbLAryB8OEKw+txZj+84PUhhcbX1AzaVwLve3txcOMQG5etkteQdCSdHyQWUTDOcgaBSbVwXt9ral92ouRMe1yK8aUzF0mNxfKYTCrCmogmIWsJsN2JSHLCEHxcLvzDFtl3KGfFks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cantab.net; spf=pass smtp.mailfrom=cantab.net; dkim=pass (2048-bit key) header.d=cantab.net header.i=@cantab.net header.b=dYnzxSgB; arc=none smtp.client-ip=94.76.243.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cantab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cantab.net
Received: from mta01.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id 8347020646;
	Thu, 24 Oct 2024 23:24:56 +0100 (BST)
Authentication-Results: mta01.prd.rdg.aluminati.org;
	dkim=pass (2048-bit key; unprotected) header.d=cantab.net header.i=@cantab.net header.a=rsa-sha256 header.s=dkim header.b=dYnzxSgB;
	dkim-atps=neutral
Received: from localhost (localhost [127.0.0.1])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id 7B2452049D;
	Thu, 24 Oct 2024 23:24:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cantab.net; h=
	content-transfer-encoding:content-language:mime-version
	:user-agent:date:date:message-id:subject:subject:from:from
	:received:received; s=dkim; t=1729808695; bh=qqIJlHei51+mon1RXHy
	lAf1fEh2i+ZRxxzyhDDTW4Ys=; b=dYnzxSgBCIk5+xpw+GDv7jl6WlWg5NBBCiZ
	IavMYUZ0/WBgei4D9StqS89S4juiciJ2MmFrA8/4Atsb8KgY3ljcPF13XpDhDG8q
	mMYeYG/bWeVrslKrIkkZJsuKWWPnRE/rk5xuP0bteYXQuPGW+iImmxzzYQVrlIXs
	svoAGGQoQ0d85w/E7BaN+XfdHwEYp7zwnfBRn2WPwqeg3IVThblfQeOv94aArStT
	a7wXIfJiH4BoapmRdiQRietttgi3elHqmGRSsw9rvOHXigp+X+EXNHXRzhaK1Q+2
	JzM2TF47oTXq8H3lku/5hKfodBfeaci+qqcZHRrZIa8I+pcOORA==
X-Quarantine-ID: <5giZ4Z0kCEWE>
X-Virus-Scanned: Debian amavisd-new at mta01.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta01.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5giZ4Z0kCEWE; Thu, 24 Oct 2024 23:24:55 +0100 (BST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net [82.0.78.162])
	by svc01-2.prd.rdg.aluminati.org (Postfix) with ESMTPSA id 56D28780002;
	Thu, 24 Oct 2024 23:24:50 +0100 (BST)
From: Edward Cree <ec429@cantab.net>
Subject: [PATCH] CREDITS: do the decent thing
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <ff3fcde5-f8b3-4b20-36c5-68d73d0e4757@cantab.net>
Date: Thu, 24 Oct 2024 23:24:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Acknowledge the past contributions of those whom the Linux project no
 longer permits to be maintainers owing to sanctions against their
 employers.

Fixes: 6e90b675cf94 ("MAINTAINERS: Remove some entries due to various compliance requirements.")
Signed-off-by: Edward Cree <ec429@cantab.net>
---
Just because we can no longer work with someone does not mean we have
 to efface their name from history.  Whether we consider them to be
 good or bad people, I have seen no-one claiming that any of them were
 bad *kernel maintainers*.  As an international collaboration, Linux
 should be above national animosities, and where local laws force our
 hand we should not go one step further than those laws require.  Are
 we truly so small, so self-righteous?
Oh, and dear Linus: I'm not a Russian troll.  I hate Russian military
 expansionism (current and historic) just as much as you.  Try to use
 *your* mush to realise that opposing the ham-handed and secretive way
 the MAINTAINERS patch was done does not make one a supporter of
 Russian aggression.

Sent from my personal address rather than my work account, because I
 don't want to give my employer's lawyers any more of an aneurysm than
 I doubtless already am.
---
 CREDITS | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/CREDITS b/CREDITS
index 63f53feefa0a..569fad372059 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1092,6 +1092,10 @@ E: cider@speakeasy.org
 W: http://www.speakeasy.org/~cider/
 D: implemented kmod
 
+N: Evgeniy Dushistov
+E: dushistov@mail.ru
+D: UFS filesystem
+
 N: Torsten Duwe
 E: Torsten.Duwe@informatik.uni-erlangen.de
 D: Part-time kernel hacker
@@ -1352,6 +1356,10 @@ S: 600 North Bell Avenue, Suite 160
 S: Carnegie, Pennsylvania 15106-4304
 S: USA
 
+N: Vladimir Georgiev
+E: v.georgiev@metrotek.ru
+D: Microchip Polarfire FPGA driver reviews
+
 N: Kai Germaschewski
 E: kai@germaschewski.name
 D: Major kbuild rework during the 2.5 cycle
@@ -2141,6 +2149,10 @@ D: DECstation port, Sharp Mobilon port
 S: D-50931 Koeln
 S: Germany
 
+N: Ivan Kokshaysky
+E: ink@jurassic.park.msu.ru
+D: Alpha port maintenance
+
 N: Willy Konynenberg
 E: willy@xos.nl
 W: http://www.xos.nl/
@@ -2173,6 +2185,16 @@ S: Markham, Ontario
 S: L3R 8B2
 S: Canada
 
+N: Dmitry Kozlov
+E: xeb@mail.ru
+D: GRE demultiplexer driver
+D: PPTP driver
+
+N: Sergey Kozlov
+E: serjk@netup.ru
+D: Media drivers for ascot2e, cxd2841er, horus3a, lnbh25
+D: Media drivers for netup PCI universal DVB devices
+
 N: Maxim Krasnyansky
 E: maxk@qualcomm.com
 W: http://vtun.sf.net
@@ -3000,6 +3022,11 @@ N: Peter Oruba
 D: AMD Microcode loader driver
 S: Germany
 
+N: Abylay Ospan
+E: aospan@netup.ru
+D: Media drivers for ascot2e, cxd2841er, helene, horus3a, lnbh25
+D: Media drivers for netup PCI universal DVB devices
+
 N: Jens Osterkamp
 E: jens@de.ibm.com
 D: Maintainer of Spidernet network driver for Cell
@@ -3397,6 +3424,10 @@ S: Neue Heimat Str. 8
 S: D-68789 St.Leon-Rot
 S: Germany
 
+N: Dmitry Rokosov
+E: ddrokosov@sberdevices.ru
+D: Memsensing Microsystems msa311 driver
+
 N: Thiago Berlitz Rondon
 E: maluco@mileniumnet.com.br
 W: http://vivaldi.linuxms.com.br/~maluco
@@ -3594,6 +3625,15 @@ N: Marcel Selhorst
 E: tpmdd@selhorst.net
 D: TPM driver
 
+N: Serge Semin
+E: fancer.lancer@gmail.com
+D: MIPS Baikal-T1 platform; MIPS core drivers
+D: Baikal-T1 PVT hardware monitor driver
+D: Designware EDMA core IP driver reviews
+D: libata SATA AHCI Synopsys DWC controller driver
+D: Synopsys Designware APB SSI driver
+D: NTB IDT driver
+
 N: Darren Senn
 E: sinster@darkwater.com
 D: Whatever I notice needs doing (so far: itimers, /proc)
@@ -3636,6 +3676,15 @@ N: Joonyoung Shim
 E: y0922.shim@samsung.com
 D: Samsung Exynos DRM drivers
 
+N: Alexander Shiyan
+E: shc_work@mail.ru
+D: Arm/Cirrus Logic clps711x architecture
+
+N: Sergey Shtylyov
+E: s.shtylyov@omp.ru
+D: libata PATA driver reviews
+D: Renesas ethernet AVB, R-CAR SATA and SuperH ethernet driver reviews
+
 N: Robert Siemer
 E: Robert.Siemer@gmx.de
 P: 2048/C99A4289 2F DC 17 2E 56 62 01 C8  3D F2 AC 09 F2 E5 DD EE
@@ -3868,6 +3917,10 @@ S: 1 Laurie Court
 S: Kanata, Ontario
 S: Canada K2L 1S2
 
+N: Nikita Travkin
+E: nikita@trvn.ru
+D: Acer Aspire 1 Embedded Controller driver
+
 N: Andrew Tridgell
 E: tridge@samba.org
 W: https://samba.org/tridge/
-- 
2.39.2

