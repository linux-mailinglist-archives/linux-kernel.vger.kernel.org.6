Return-Path: <linux-kernel+bounces-381794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 076419B0488
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2B6AB22D91
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3521F757F;
	Fri, 25 Oct 2024 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="hEu00asD"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAD0139D04;
	Fri, 25 Oct 2024 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864294; cv=none; b=DnVvOMrjz2dch9jKZ85JKL14G5chOx+yCsv/UDAaUc4y236dxuWQ5aoHAQDDfI7DF+5cWQo3dix9w7XdSmLK5nyQZWoYBKWi3ij6xFTiS0ZOVRrxeejd7BcX8UcyTzDdWr1MLwLr89ziFTSK9mZT245ffXoRq0IfLu3XWo9foQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864294; c=relaxed/simple;
	bh=obg4rXob060iGRzUDraUr9IY55MEeO6N5oya//idfX0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gOCoP2mgt7sVtkFY9f43vvKbJevk+T0Hy9Bvcx8/P3/CH9gTBHyvTNcYPz39o9I5IQbiZW74Z4pp/1ucGX+pDo6zFzXZX/Ku1SJhDSmBKOxqyPuFhts5KZslgMTQ42och5IERMMjpCOchXppL5bGzy+GfouO8gLMKgVyAV1Jz1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=hEu00asD; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id B2A82177100; Fri, 25 Oct 2024 13:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1729864288; bh=obg4rXob060iGRzUDraUr9IY55MEeO6N5oya//idfX0=;
	h=Date:From:To:Subject:From;
	b=hEu00asDZhEDyZcc+HnpHwqQjYYtAfU8zMmX3tos6PzHgcbFqVY2Xu0nOFMpOTwip
	 cauq7Nfu3RUKtaCByevjFbLjT2RHO3M4AHWiC/QnIsyjl2eFQKasMvsPuS/t9aryCq
	 cu+zelVlsqtCCTP0Vvdg+bo7HJuyFhxSBcd6qibUb59t5tDCo27UICYbbYYvWY3z4J
	 TVYtrYRud8NvT+1aj++ltwC7Yd96Jy0X1SsdrUhVTpjbTxG4sHc999UQevQQvcOe/G
	 FG31bOYwUvL0dsj2H8VJ+TU8N8iay/4djvToeMmQpcZa3JdobNZEmCcJgluCVBI7ze
	 G7922XRXd36Sw==
Date: Fri, 25 Oct 2024 13:51:28 +0000
From: Nir Lichtman <nir@lichtman.org>
To: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix incorrect paths/magic in magic numbers rst
Message-ID: <20241025135128.GA879576@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix some no longer true header/c file paths and correct the BAYCOM_MAGIC
value to be decimal as in the source instead of incorrectly hexadecimal

Signed-off-by: Nir Lichtman <nir@lichtman.org>
---
 Documentation/staging/magic-number.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/staging/magic-number.rst b/Documentation/staging/magic-number.rst
index 7029c3c084ee..79afddf0e692 100644
--- a/Documentation/staging/magic-number.rst
+++ b/Documentation/staging/magic-number.rst
@@ -68,11 +68,11 @@ Changelog::
 ===================== ================ ======================== ==========================================
 Magic Name            Number           Structure                File
 ===================== ================ ======================== ==========================================
-PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/linux/pg.h``
+PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/uapi/linux/pg.h``
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86/kernel/apm_32.c``
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/linux/fs.h``
-SLIP_MAGIC            0x5302           slip                     ``drivers/net/slip.h``
-BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/net/baycom_epp.c``
+SLIP_MAGIC            0x5302           slip                     ``drivers/net/slip/slip.h``
+BAYCOM_MAGIC          19730510         baycom_state             ``drivers/net/hamradio/baycom_epp.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mips/include/asm/sn/klkernvars.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/coda_fs_i.h``
-- 
2.39.2

