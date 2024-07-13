Return-Path: <linux-kernel+bounces-251411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5735B9304A0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 11:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BA21F23056
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 09:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8557149637;
	Sat, 13 Jul 2024 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="g+nIF5An"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E374DF51B;
	Sat, 13 Jul 2024 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720861267; cv=none; b=kr4LlcpTlGbNPReqbW7VZnvb1rO8kZboxMYaEvmDroc3/BToCGNMu1V4r5zqjK5Xrcgg6HaUPlGP9vuy1GYFrsLkMR3OruLCWtuf60cu9oDVrBHNtV4nvstkY8X6+KR3fOLGrTBAFirl7GnnkHTIjhUbLevxVT43bsATNz5A/Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720861267; c=relaxed/simple;
	bh=AU4aZ1uPRSLMLiFt+ciYhu5p+gCYQFcXXg7tP8WhCsc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=U6Rmt81q0Sr2rhf/NhDab5YjUiW5046fFfU8On6f1G50GpX7aVDThQ+aE/I/pw5Z1RHB8ebvYiedGzr4hfyWwDUUUz6QBwlTyOu+QKHPu5fB0/aVNT31yCol1aq6aYTD/kyeZ3aukDrJcmQcmKLdVqFBn6oyt/qR86hJ3Gnw85E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=g+nIF5An; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720861230; x=1721466030; i=markus.elfring@web.de;
	bh=rxSz+nti3Y7xyZJUy2uJZMnwJpt0QbSgZPWpnBH8KVY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g+nIF5AnukW3CbaO6QmKU3hcfGr2OLTXyO76ASRa3jsbld4IpHZ0S1a08yXqI3IN
	 pZHPWpYfVxshqbeY9pKtFig+P5NFnwsBQ2irrLXJ5nCsoLpEASJpUw8h5OpEDEK3n
	 eHFv5/icPjzrFcRj8lFCJ/N4TE5nNVyLbffkXvUKNc9W9TSPVDkI0ofo3vAoPEd/x
	 zKaGsS2RUr+cRz1y2JOpCA/X+/wkQtltb5aiyThr2vYg1oD1XI4AsbVDl6MiY5RLA
	 +JpLLyAJqLe1J3kyMZ4QcHYsMpBjh/sBhcaAjnvVpxPsandYi+Q1Gbv2wtZ+cMefO
	 pXOpxK9TsiEjSsI8uw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGxMP-1sWjTa4BTX-00GtG5; Sat, 13
 Jul 2024 11:00:30 +0200
Message-ID: <d4be0dc8-f6db-4bf1-bb6d-ccff161dfde9@web.de>
Date: Sat, 13 Jul 2024 11:00:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: x86@kernel.org, kernel-janitors@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] x86/resctrl: Use seq_putc() in two functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YwND3k/hg7wTMF5WfdBpQioSbMiWFoEM2imh2B5V1MFOLCiWkKT
 csvnDxFRxJywlqvznHnUf7x+e+nK1m1ta50qEjzV8yusA0Vix4EeP96cQNiB+4aiQmmKO/o
 CWkhD6KAnRqe2rdUW983zTrLsG3SM3u/bTOQgl4/fAoIFwuQ/4Yhx9qTvXSGgUZ5d3YVpCQ
 XkCrTCB77kC5Uh6NbQUYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hgNA7d5SdZQ=;ByellkoZIVUw3fH2XHP8q5x/s/M
 mDD1oAu9A/hEwP/NVhTPjxrXQqU1OJSYd4gYawjNEzdL85t4OsB3DtKsSaT7iVsd0nJ5ZymZM
 pPiCpyQXTQSWeiHrD0EIedMA8MJfmgNanIWvWY+6Z5Xd+mFRlzW3R1ImUiQwtAh6yWg6JRJtP
 ccNtu1fPzI3ITE/M2GSRgvOc2wqeSCsvfuCMpS9XvulGGLBtefDOAcLTHkV1zRsscVAdLrfwl
 u0hZc1T2FUSTFIubI9o5gvKLQRPoN4emS4g6SuWAxZDbln/CNwYr700Q/h/qLzdJGPjBasDgG
 LJykdgH7ur+VYCDNYVScc8j7g6jwQ8MiUYHOJpCJXS4+en5tyU59SDy/oqdIbA434SfQrC0sg
 ZgcMT8M6w+vOoID04BfXjZAZ0bNX0vogwWr3b2aSkvFOvJgjM5P9dihuewjEgN6Qgo1sDkJHj
 orqMxpypJ9pcGcDIlXTjaNIwej6IbphG3UqexsIx9ozxN8y/uIeHhmYcPfuYvQVpPf40dzJZ4
 sMt44SnEVF9fKRCTLiWab3mwxnZqt+Y+6kM/7to0jjFPqHK+zanMwBYwCEfvxSGTrdSWR55tY
 EMbFeeVVL4SBPa9mbdsNC7YhV3nf8evlfn9JVjfiYOXMsnRUkXi0kjnTGahSApJRvXejB5G73
 qQGqeqMDnAsjoWK8BjV591aQ/HNhNZ/A82w7zn47LX49w1NfnMOWOfK2uOKJiUZ3jnvHqa7kw
 kWcRQuqaFr77vzeiKkMHFG3kSZ0QQ/FY2d/TAXQIa5t1J9rQgAlSF6C4v5LDhkdnkHKdFxq2H
 sFy9UUfDYTWxUxPsLY/46vFg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 13 Jul 2024 10:43:14 +0200

Single characters should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 4 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/c=
pu/resctrl/ctrlmondata.c
index 50fa1fe9a073..dce68f19c29d 100644
=2D-- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -452,7 +452,7 @@ static void show_doms(struct seq_file *s, struct resct=
rl_schema *schema, int clo
 	seq_printf(s, "%*s:", max_name_width, schema->name);
 	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
 		if (sep)
-			seq_puts(s, ";");
+			seq_putc(s, ';');

 		if (is_mba_sc(r))
 			ctrl_val =3D dom->mbps_val[closid];
@@ -464,7 +464,7 @@ static void show_doms(struct seq_file *s, struct resct=
rl_schema *schema, int clo
 			   ctrl_val);
 		sep =3D true;
 	}
-	seq_puts(s, "\n");
+	seq_putc(s, '\n');
 }

 int rdtgroup_schemata_show(struct kernfs_open_file *of,
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/=
resctrl/rdtgroup.c
index d7163b764c62..d4e216073e7a 100644
=2D-- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1605,7 +1605,7 @@ static int mbm_config_show(struct seq_file *s, struc=
t rdt_resource *r, u32 evtid

 	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
 		if (sep)
-			seq_puts(s, ";");
+			seq_putc(s, ';');

 		memset(&mon_info, 0, sizeof(struct mon_config_info));
 		mon_info.evtid =3D evtid;
@@ -1614,7 +1614,7 @@ static int mbm_config_show(struct seq_file *s, struc=
t rdt_resource *r, u32 evtid
 		seq_printf(s, "%d=3D0x%02x", dom->hdr.id, mon_info.mon_config);
 		sep =3D true;
 	}
-	seq_puts(s, "\n");
+	seq_putc(s, '\n');

 	mutex_unlock(&rdtgroup_mutex);
 	cpus_read_unlock();
=2D-
2.45.2


