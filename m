Return-Path: <linux-kernel+bounces-390393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBD49B7952
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A787F1C224E4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D3B19ABD5;
	Thu, 31 Oct 2024 11:06:31 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26939199FDC;
	Thu, 31 Oct 2024 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730372791; cv=none; b=otp3c+LTvyiyau7AT4la7wHtQlCqTep/GTvbRuTRPg7sNytLhvsIKoLSCDe23vTgBRLkvAMDNW5Vpj/pF4yUiev+o8fl1AIREojRFugU/slXnWyzA+Yey24lYYXnvRyhKuktbp9scOFTkImTyJz3I1Vik9SkmZVC+kFcVphgNEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730372791; c=relaxed/simple;
	bh=ZEwEqixcj6ft7PZBzEBsHv+EiCt+eS9FQT2H/Xqhx0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GnoHpXULLsE+xhy9DdmuDhX3oGxmSIgmS8tz5J8TZeVFVhiHVnkPzY3t5j6evFNye03a6m4KmLg5CIOk1hxK1Vv4N+XbWIYBBf/4T0tG8n4bEfzVszccD2w/2fxsLSuSpPubpocvYtLLziymY3RyjuVEvQSRJg0uOnr/BJ/kksU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aaddeso417149a12.2;
        Thu, 31 Oct 2024 04:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730372787; x=1730977587;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h18s88CLX8JiqpfQaDviuaecMfdKomNEp9V6gWdT0T0=;
        b=gU3kZ9ttEuzgjtFWncBKQ3dmOBJBcEGIYQXp1mwfNUoHinEmgLVo3m1IDlQHis2/ou
         kakaMV8CrtpR1o23uoigGBdYbZ1nIsBGRToMTgeRw0fLQT9iP+Y0934pRVVOzvLw+ETL
         lLUJ+P4ZS9kYUw75EucUUgW3Z7ibR8TeF/Usd+bqf8NP6gwMGpO1ZAaHK9BpEBoIftMq
         +NPi06Lkon3q+OkgettvQGl3MwJy1B1Y0XtAkY7unIe2lpHGk0k2ixCNjtlVB2g7cC/g
         AIoCP2mYyf85kAv9jICp/RX4ScSwPkjNAF3RFWx1lDqJy+h3NVDdQ1OgDS9jmOtuU4g6
         JqcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh9r+87XKTMAKseahOBzJJ+u4ZaU4pG4RIzOay+OujgYnZH0Y0jJbrolAxnpBVa7tr4EAyTQlIe+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC9cp34A95l/jtPfezTQe7s2T0R+ulNP5yj2oTBHOL3ATyVQTC
	aWkyhzhhg9U3PvVqRyD6VgTjIzPxFcEHkFXggecK8VKhGYqa7G+H
X-Google-Smtp-Source: AGHT+IFUpxA87yGLca+7yFvdoDwW9Luvv3EpQL56AAyRakTZWFo10GnD3fEzXjfeaUWDuCnDrnO/qg==
X-Received: by 2002:a17:907:9713:b0:a9d:e01e:ffa9 with SMTP id a640c23a62f3a-a9de5f82589mr1641491866b.33.1730372787281;
        Thu, 31 Oct 2024 04:06:27 -0700 (PDT)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c615bsm54790366b.80.2024.10.31.04.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 04:06:26 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 31 Oct 2024 04:06:16 -0700
Subject: [PATCH v2 1/2] x86/bugs: Use cpu_smt_possible helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-x86_bugs_last_v2-v2-1-b7ff1dab840e@debian.org>
References: <20241031-x86_bugs_last_v2-v2-0-b7ff1dab840e@debian.org>
In-Reply-To: <20241031-x86_bugs_last_v2-v2-0-b7ff1dab840e@debian.org>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1791; i=leitao@debian.org;
 h=from:subject:message-id; bh=ZEwEqixcj6ft7PZBzEBsHv+EiCt+eS9FQT2H/Xqhx0I=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnI2SvRpv11buT8J7ULL6F4UFG5en8+qjkqaCK7
 GMFtwLij/GJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZyNkrwAKCRA1o5Of/Hh3
 bY0UD/45wgDHLM5osYntnuTrgsYRum3q3vIJg72bJdxRrSh6SmbJIUSPPsy4DpX0HKwlRFEnM4F
 YFDTq8K4+LUHaNbriwpDM2Q9vo8nCSUzYhGf/wOgxGDhIhw5nmmCgM4x+qO+BEKfRXNP9lT8SF1
 +PIq4duBguPtEDmuCNjpdT52UkUeX0AXzLh7W+epgJES6oJIRxZIWTEI6q0tZupzD5a/6oWClIL
 NSvZAouj2vYUtVsYK6puP5hBTSFwHBn1Lz9GKOwE//hJGdiXdhitM0o7qmroMM/tc6c3/X+abMU
 sU8zb2T355kRSi6KyA+e023i6usbNVP/jZ9lA4VQKsvP5GDsreEdQmZVECDQPEWG0VX9behH1bV
 Q9/syoZHpcGHwuhX83o28OeNlzLaXzFqi4FLnVnXUoBcvKvpozQkdzQQXxOMnrW38wR0vhIfM2W
 li1/oGuL1X34WXFv5bx0I1i7c58dlv64WWlJfOrSgDYguHgVBknSk9sEN7ods7dIc/aDbfJ/3Km
 IsHRe1D8qQZVnw069RZBp2PtuD8mCel8vgRA8KMMB0fEDp6VKLwvCTOUOuk/4K8dkgE0A00xvcn
 apfoPlrezYkht4KoUMGGs9ImL7n4HjnQFIqv8I9zW3M5qMaEzrKC9kX9PmvHVXAacSayP30He6+
 Sfbld3YCjY5yInQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

There is a helper function to check if SMT is available. Use this helper
instead of performing the check manually.

The helper function cpu_smt_possible() does exactly the same thing as
was being done manually inside spectre_v2_user_select_mitigation().
Specifically, it returns false if CONFIG_SMP is disabled, otherwise
it checks the cpu_smt_control global variable.

This change improves code consistency and reduces duplication.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 47a01d4028f60e012d1e625e1667842b52948038..ceaa5f0c742025a62aa564aaa9cdfa1fe86e681c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1332,16 +1332,11 @@ static void __init
 spectre_v2_user_select_mitigation(void)
 {
 	enum spectre_v2_user_mitigation mode = SPECTRE_V2_USER_NONE;
-	bool smt_possible = IS_ENABLED(CONFIG_SMP);
 	enum spectre_v2_user_cmd cmd;
 
 	if (!boot_cpu_has(X86_FEATURE_IBPB) && !boot_cpu_has(X86_FEATURE_STIBP))
 		return;
 
-	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED ||
-	    cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
-		smt_possible = false;
-
 	cmd = spectre_v2_parse_user_cmdline();
 	switch (cmd) {
 	case SPECTRE_V2_USER_CMD_NONE:
@@ -1402,7 +1397,7 @@ spectre_v2_user_select_mitigation(void)
 	 * so allow for STIBP to be selected in those cases.
 	 */
 	if (!boot_cpu_has(X86_FEATURE_STIBP) ||
-	    !smt_possible ||
+	    !cpu_smt_possible() ||
 	    (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
 	     !boot_cpu_has(X86_FEATURE_AUTOIBRS)))
 		return;

-- 
2.43.5


