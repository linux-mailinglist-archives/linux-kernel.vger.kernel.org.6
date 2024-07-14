Return-Path: <linux-kernel+bounces-251887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3F3930B09
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 19:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D662C282260
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 17:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9604F13C810;
	Sun, 14 Jul 2024 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="UzIcgdIv"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3773CB64E;
	Sun, 14 Jul 2024 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720978775; cv=none; b=r6UcUJHfOfxZOQfQc8mXarc4Cdj64XRfPJqrHYyqICvdTZzHDfgoeQ8KbhGt0tWZsGkHMR+HujpKW2GflKxNLWy3BD62PCdUiMoV0Vm/LKkZ15Rhtd/pfF0Iij8obBdMps/uzICgZKmz3JSyemdXLw4AY3jHX5mg3CXtPlZhzUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720978775; c=relaxed/simple;
	bh=wGSN7fvoHntNgMloKkNcMVe/RBb69hQKx3jw2zCodpE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=EK0SJkBZlchrblda+p/7BPtBFryeuY7cb3KTwOJna+j+OhJpxEv9F72LJy7cQzbJRuSd9cLe2p/HNzl7tohmbaOvkyTEMPfKDaIaS3L3qe7z27lip1GgYtzGnYdwYnY3kaShdgu3N8Ie8zCUrlNQYr1SGP+09AS39J1Z5St82Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=UzIcgdIv; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720978764; x=1721583564; i=markus.elfring@web.de;
	bh=lfCZA98CrFP0xDtg0gNKGjTj/w1gvpokK4i+/2Wzbp0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UzIcgdIv2M54GDd3TtYZKEnf3kbeswUo2qtIWVNbuLMnNduMm+1Mp+PAmhVqh4Vb
	 a+zQQw7M1FZhsJRO2FeT1GsNO5Vy4O8Ici0YEfyQvqlM5gm01o+inOH0/rXRH244V
	 P2lOUv2DlWPcAgRtmyOVxC+u6KuKhOsYTBWUwTz07lpMerhqfxGffgF74MfheREVN
	 LZ3YObarIVsKCX2lllGhz4DM/yqV5d+uBYt24jdwcCvXjRsyrm0XWyV0UWFkR9nqO
	 oCIUERZ6rZdsQs5QFUSfbRyv/1WQIjF1VgIPLV6PqTwZRCSAsdDa/V9tRMlY0xP/0
	 GU0+3++uyXmd+tcwgA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqqTV-1ryiSr2Qcb-00nZsE; Sun, 14
 Jul 2024 19:39:24 +0200
Message-ID: <375b5b4b-6295-419e-bae9-da724a7a682d@web.de>
Date: Sun, 14 Jul 2024 19:39:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: kernel-janitors@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Jason Baron <jbaron@akamai.com>,
 Jim Cromie <jim.cromie@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] dyndbg: Use seq_putc() in ddebug_proc_show()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:19JYC3+67N8xdorzyxVHVZrm9LS/7soouEUm4qPsgEg8biGHrXn
 H/LApUzhNm9KLUJyDTIsOP3JgS0vcTj86mS81Gs5jaQ3Mkae+59620kpvhqF7u4ufd1ORkE
 k6qHSHwhpZ0teQGTN3tjwVStmkMt/xMjycAab82Mz3oFx4wjB4cdMlOqG6xg70fKrgAFSbn
 adk7VyGHs0XVpJBSz+ATw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dimaTLYA5S8=;c0DurgVX8itb0h5FksEwkvs315u
 7i9cLKGxWZIe+sWvzBRQaGBYrR9NqEMLRK4uu45ROLv58YcPzAasz+9AaAbcOIxqhrbacDXf8
 pFDIMZOUFueyg0LTre2bcqGn386fIpkIvG67ObMU5O9gxWsXtZvzvYPH6RY/3/OeRDas+S0aV
 HNpt8ZvreNEoX5KY0tIpwg3zJ4SFXUmL1DdO83Tc+ccuaK/lre8+Joh7ri7fSANSLN8SlCtYJ
 2j+OSuiiufbzk7xbVHCWXbmX2lyRj3/UvVKQoE7sV+MxprDFpbxwezBdCNTNvWByQtCAW1Ygv
 NHoiFFTvYgZM0EbR/T+kz2CyRX+PLcrGLYPJE/EgXUmjlaZU/CmFwi6qITCFWiFpHM9O7kjyJ
 n9AP8mSeUToT80mh9bPX/1++rANKkTrA923yrvipWXa7spnC4Ot7Xs2LfhPAiOUuDjr3vqAL5
 Dn+MkG0SG/IcKFizZN46TkNVKnOuTnF5ftyMjrIm5Uso9yFxfNJ4PP6W/eM36O+e7G1w9WEUv
 mhidEGOOebcj0uCZOUu/JutngXEimTmXBIb6w0xlmP1Jb+zeqlByhlGV+0hbaAL8uD5l3TjIU
 Pjdsf+E1nHjvHFx1klkj5gWTLJdEuVzEK4yJS83rGAtTAMySyjMmdJ+GMN5sFeCC4np2XZkjg
 N2bJh/WS5J4rH/Zu28+lceVAUKcRej8Ri2YRLduUpOk7YDRB8QXhj7ytydyRwSOBOpkjkVFfv
 +Ghp+cf8YlMb8P0gE9KvX64OcyivsuFBs9UOeFko/+ij1FcbW3piUpd+E8fkf4vd7LaFg/MFE
 t/o9EKNyWxXPtTCb2maXGSkw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 14 Jul 2024 19:33:07 +0200

Single characters should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 lib/dynamic_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f2c5e7910bb1..5a007952f7f2 100644
=2D-- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1147,7 +1147,7 @@ static int ddebug_proc_show(struct seq_file *m, void=
 *p)
 		   iter->table->mod_name, dp->function,
 		   ddebug_describe_flags(dp->flags, &flags));
 	seq_escape_str(m, dp->format, ESCAPE_SPACE, "\t\r\n\"");
-	seq_puts(m, "\"");
+	seq_putc(m, '"');

 	if (dp->class_id !=3D _DPRINTK_CLASS_DFLT) {
 		class =3D ddebug_class_name(iter, dp);
@@ -1156,7 +1156,7 @@ static int ddebug_proc_show(struct seq_file *m, void=
 *p)
 		else
 			seq_printf(m, " class unknown, _id:%d", dp->class_id);
 	}
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');

 	return 0;
 }
=2D-
2.45.2


