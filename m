Return-Path: <linux-kernel+bounces-169810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654C78BCDEB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9747B1C23794
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75676143C51;
	Mon,  6 May 2024 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQN4OuUa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF824143878
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714998532; cv=none; b=JWPRnjiMVrWVEgoI/JWFrPRAM9J99GbG29APKSwEYz7PXNQ0ZeNHgWRipeNJ9/c8zhI5EowKhd6oxJzgDbFR0Qjj38z0tIir/EP/tKSdP7fMlnMETY9IQ6xFGTexuv3MfNwLpwaDmo0J30PhgukHRau3JseSkmuTTMjXbV86UWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714998532; c=relaxed/simple;
	bh=VJIWFsG1cEJbWujrWaBLdrsD0pmz5MwKtoHH7+MTl4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qqbGtPfvk/dIcygIvxSUsvRtzlJ6fEpB2t0zFfc5mX2264+E+C8oCA+66nj+/1c+2VoMasubHShfcBzCBpkzmebHehELH9rPuSHFQTA8hYRCVVPVraN5gZ6sPDmE+SZa+w80cXyWwmFvd8qRC09Y8qpEGQvHfmZiMkdS7hW6MQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQN4OuUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84076C116B1;
	Mon,  6 May 2024 12:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714998532;
	bh=VJIWFsG1cEJbWujrWaBLdrsD0pmz5MwKtoHH7+MTl4c=;
	h=From:To:Cc:Subject:Date:From;
	b=CQN4OuUafFIUjUF4Ecrqv69EzW862+6Pc2/MQzRVJyS+ryV2r/eDMAFK4XIUj4C/V
	 ZE+FtNH01HaHoK2N4WfmS9QquQ3RYIVmMwC9/WmK9oiewr+7SNerZb4rB7/ta2Dwp7
	 QR10hrZCNJVciLSadaRxHz4ASN/HRgfB7Wa6BhbKpN2OihaWMoflda68SNzMIQdGXl
	 Zr3acmUKxSw7tmRNolxduhHV+CC2zthOa/IkSmax5wAougNstqQrmbuvQF1mHNCH2B
	 TylvkV5M9qeCQpjlCcuQBn4rnq7LnGgh7HO861czwS3OEUfvLnGaZprqrpapFq3ced
	 uMkqfJyRbAA9g==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH] x86/alternatives: Remove alternative_input_2()
Date: Mon,  6 May 2024 14:28:48 +0200
Message-ID: <20240506122848.20326-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

It is unused.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/alternative.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 76d66bf7bfeb..1237d6647f21 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -350,20 +350,6 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	asm_inline volatile (N_ALTERNATIVE(oldinstr, newinstr, ft_flags) \
 		: : "i" (0), ## input)
 
-/*
- * This is similar to alternative_input. But it has two features and
- * respective instructions.
- *
- * If CPU has feature2, newinstr2 is used.
- * Otherwise, if CPU has feature1, newinstr1 is used.
- * Otherwise, oldinstr is used.
- */
-#define alternative_input_2(oldinstr, newinstr1, ft_flags1, newinstr2,	     \
-			   ft_flags2, input...)				     \
-	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1,     \
-		newinstr2, ft_flags2)					     \
-		: : "i" (0), ## input)
-
 /* Like alternative_input, but with a single output argument */
 #define alternative_io(oldinstr, newinstr, ft_flags, output, input...)	\
 	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
-- 
2.43.0


