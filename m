Return-Path: <linux-kernel+bounces-268405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D657942442
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 03:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5359F1F245AB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D5CC8FE;
	Wed, 31 Jul 2024 01:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="YXVnhwlm"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34055611E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 01:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722390392; cv=none; b=FnZEohBje8pQqckt0N7qd1p8uA6CEy+7ykH2alcz/iGQhBrcEgIF7hoNBi/ejKkvAVAH+WD+Wd1PgdEG6m3ZO1dUSNzKanJbSoY1d9DuTDd69LJnnVKT9uS7eERlnc10GqZ0RywzcjUSgTFHlxT51/sp0tI0HosES0A4+DbIIfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722390392; c=relaxed/simple;
	bh=0/SMHsQ5GFP1SYelao3d4uBDo1h/f3V/0+rr2srgbz8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=YDidzMtbidSyTS0aUBtsne4ONLF+G2Gpv+MqCmwnW2KIQ15fmh8j4NkkJrJzlB1U+8dAFZg34hQSQbHDRveoi7NqXo9wo4yuvNbKdt6Zy5kXqF4cuah0Efq8rE60QKbctfg4bBsooElCAI0dSLs8NJetSSnQKBhdwKHBbjJAqnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=YXVnhwlm; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722390079; bh=0YnGlQQErURyORVXhFMswhQ2w8rLKaqeuF6cRmjL07w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YXVnhwlmC4Cg0yC//4JMe4mgSD+eiSy2eIO7c1NGFfsz1jLvaHc1tf/ebM/2Bzpuj
	 uX7/tN6eG6vNJz8fZw7r4y29+crruasTO5+YSpsjJ64xLRC40VTFjYI9pNI3KKx/D6
	 r60nh14a7+j2eGM79v6H4ArmuD9esmYI59ef2wic=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id A5222229; Wed, 31 Jul 2024 09:41:18 +0800
X-QQ-mid: xmsmtpt1722390078te6iojzd8
Message-ID: <tencent_8D66803C29363A97EC36024BCE7451774309@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTbeuRV4gZUOlQZy+w9WVl6Tb8f+fgk9qMRkb0FFiZLkNW7jGmCT
	 oUolzXzddpm3nglWB17QtZLULy6qTwiZ8DGPvbadUVxauo+VY93mmlQpM0P3En5ZDUcdjEIxiFyl
	 bGlDy1wlnrR5U6AMYR+8tn4mwVcBQ9Ngs6AAP7758aWP2i43H56WMeifhImxLxpjsziZGA5Y/tVf
	 rz+WGWZ0nzNDidj+O5TV4zqzzwyQDaCh0H49zL2yRxpuqQx9SfbQ95MYMDpUOKLNIKPbK1X+wgbm
	 JZJNjbOuHC+wtgpflTTjV15T3BVHFaaq3njCMkRK0ODap3aowoha5kpmCa7TcpxJrWF06QBK4+yz
	 ov1NmiN7CNVYqh1iZp1mLny5WuAebidB+TFQRpYzF5jPabFoDAnTzwDiMbzPg/GUsJuIsoJvZcJw
	 FqdlkXgfYUeiPxm89avzTMLEzBi1fIt2JXvt/v6voybreOl2SG/Sw1EdV4vlFKOalZOHdmFmVWl8
	 IiPR5mgJ9bWamdbw2Ff67LdM/FO5nRclBlqKqh4RpfCF9Rq4cf0JwIRy4+LK2T/CzCNa5OJ86GqX
	 bGs73Uj0Cdk+lE3fphA7JAA+90k9s0A2eq44ZmHO24AkIxKogDLge8uxI8sRs3MWruaLb4sHP29X
	 /2z7cT/A/gkVTNiB3IdSf5b20aMGF0TLcl9IA3P3Scvs0EeFawAl9mhWV3O0XErNa4Y+s0KbHFWR
	 M1QWZipRQh2PPOnAo8hHNC946YRQl7bQX956zdyD5OA1/uvCOcDdtDeTOQ8SA2ZbM/W8u4VwpsL5
	 K0MQ7WdIB4G9JD+ia3Xt0S6AWyHFCxzeD+O4/3DV31qrnOB2UHSvPiZwnm/9x4eObSW40lZffac+
	 eceKwW6+IJ1JCEdgDTwMCv0RINl5uWMukg8CgFVZmW9vAmOj00iTMPg0GpEAgAPw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+05d7520be047c9be86e0@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Read in journal_entry_dev_usage_to_text
Date: Wed, 31 Jul 2024 09:41:18 +0800
X-OQ-MSGID: <20240731014117.47582-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000b2c0fc061e6cb26b@google.com>
References: <000000000000b2c0fc061e6cb26b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

entry data bytes too small 

#syz test: upstream 1722389b0d86

diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_format.h
index e3b1bde489c3..d536da101e89 100644
--- a/fs/bcachefs/bcachefs_format.h
+++ b/fs/bcachefs/bcachefs_format.h
@@ -1252,6 +1252,11 @@ struct jset_entry_dev_usage {
 
 static inline unsigned jset_entry_dev_usage_nr_types(struct jset_entry_dev_usage *u)
 {
+	if (vstruct_bytes(&u->entry) < sizeof(struct jset_entry_dev_usage)) {
+		pr_info("entry data bytes %u is too small", vstruct_bytes(&u->entry));
+		return 0;
+	}
+
 	return (vstruct_bytes(&u->entry) - sizeof(struct jset_entry_dev_usage)) /
 		sizeof(struct jset_entry_dev_usage_type);
 }
-- 
2.43.0


