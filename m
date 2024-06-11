Return-Path: <linux-kernel+bounces-209982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190B6903DAE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE73288270
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF33E17D891;
	Tue, 11 Jun 2024 13:39:37 +0000 (UTC)
Received: from 10.mo591.mail-out.ovh.net (10.mo591.mail-out.ovh.net [46.105.55.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72B617DE0F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.55.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718113176; cv=none; b=J+OieF9rGtRxlONHkqJ7ZVDOWh/A/Cookna9jXxCcldUCStpr1ecW3wHfiUa5clxqB/FGGqC1eo3LtcrvlyFT6x6HeXBuUpL3cnwaAV2Ac1pYRcVI4jyAkaNHxpKN7Bj5Wa2mly1vGBQcqKAEqc2WGDsOkPDYmrXsUUeWY2DAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718113176; c=relaxed/simple;
	bh=1Yg1SrEZkzsLZuXedN93roDqOCgT2OVs9TDKSiPkt7o=;
	h=Date:Message-ID:From:To:Content-type:Subject; b=r5HyXsxjFTUfVZ/qzum9P9FavMqn/Y3TedLHs6XJbE7wAKVUzdaAiiqCDaRX7d6KufmMJfUDZt8zwszccboUVe8VMtOUOiMqZLCx12jazEyi2rcJpsm+g2DlGZv+xzD32vXyFe6VR4VcBul1BXz6QlkWoI/69pa/J/DXueGNvqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=institut-mingmen.fr; spf=pass smtp.mailfrom=institut-mingmen.fr; arc=none smtp.client-ip=46.105.55.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=institut-mingmen.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=institut-mingmen.fr
Received: from mx1.ovh.net (unknown [10.110.168.182])
	by mo591.mail-out.ovh.net (Postfix) with SMTP id 4Vz83w5fQPz16L5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:03:08 +0000 (UTC)
Received: from localhost (HELO queueml) (127.0.0.1)
	by localhost with SMTP; 11 Jun 2024 15:03:08 +0200
Mailing-List: contact contact29-help@institut-mingmen.fr; run by ezmlm
Date: 11 Jun 2024 13:03:08 -0000
Message-ID: <1718110988.32038.ezmlm-warn@institut-mingmen.fr>
From: contact29-help@institut-mingmen.fr
To: linux-kernel@vger.kernel.org
Content-type: text/plain; charset=utf-8
Subject: ezmlm warning
X-Ovh-Tracer-Id: 5407697256108911067
X-VR-SPAMSTATE: BOUNCE
X-VR-SPAMSCORE: 10114
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucfpohhtihhfihgtrghtihhonhculddutdduudegmdenucfjughrpeffkffhvfgtufesthdtredttddtjeenucfhrhhomheptghonhhtrggtthdvledqhhgvlhhpsehinhhsthhithhuthdqmhhinhhgmhgvnhdrfhhrnecuggftrfgrthhtvghrnhepheehlefgudehgfdufedvvedtheegleejveekffelueefueehleevuddvgedvtdfhnecuffhomhgrihhnpehovhhhrdhnvghtpdhmohhnkhgvhigslhgruggvrdhnvghtpdhmohhnkhgvhigslhgruggvrdhnvghtrdhimhenucfkphepuddvjedrtddrtddrudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheptghonhhtrggtthdvledqrhgvthhurhhnqdifrghrnhdqudejudekuddutdelkeekrdgrhhhfohhokhgthhgufhhmjhgsjhhhughkjhgvvgdqlhhinhhugidqkhgvrhhnvghlpehvghgvrhdrkhgvrhhnvghlrdhorhhgsehinhhsthhithhuthdqmhhinhhgmhgvnhdrfhhrpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehledupdhmohguvgepshhmthhpohhuth
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Bonjour ! Je suis le programme ezmlm. Je m'occupe de la liste
de diffusion contact29@institut-mingmen.fr.

Un certain nombre de messages provenant de la liste de diffusion
contact29 n'ont pas pu vous etre remis correctement. En attachement, vous trouverez
une copie du premier message de retour a l'envoyeur que j'ai recu.

Si le message que vous lisez actuellement ne parvient pas non plus a
destination, un dernier message vous sera envoye. Si celui-ci echoue aussi,
votre adresse sera malheureusement retiree de la liste contact29.

J'ai conserve une liste des messages de la liste de diffusion contact29 qui
n'ont temporairement pas pu etre delivres a votre adresse.

Voici les numeros des messages en question :
   1

--- Ci-dessous se trouve une copie du message problematique qui m'est revenu :
Return-Path: <>
Received: from localhost (HELO queue) (127.0.0.1)
	by localhost with SMTP; 5 Jun 2023 16:46:18 +0200
Received: from unknown (HELO output48.mail.ovh.net) (192.168.13.27)
  by 192.168.9.10 with AES256-GCM-SHA384 encrypted SMTP; 5 Jun 2023 16:46:18 +0200
Received: from vr44.mail.ovh.net (unknown [10.101.8.44])
	by out48.mail.ovh.net (Postfix) with ESMTP id 4QZbyf2gLzzTCWtXS
	for <contact29-return-1-linux-kernel=vger.kernel.org@institut-mingmen.fr>; Mon,  5 Jun 2023 14:46:18 +0000 (UTC)
Received: from in32.mail.ovh.net (unknown [10.101.4.32])
	by vr44.mail.ovh.net (Postfix) with ESMTP id 4QZbyf0BCSz3Hywng
	for <contact29-return-1-linux-kernel=vger.kernel.org@institut-mingmen.fr>; Mon,  5 Jun 2023 14:46:18 +0000 (UTC)
Received-SPF: None (no SPF record) identity=no SPF record; client-ip=23.128.96.19; helo=lindbergh.monkeyblade.net; envelope-from=<>; receiver=contact29-return-1-linux-kernel=vger.kernel.org@institut-mingmen.fr 
Authentication-Results: in32.mail.ovh.net; dkim=none; dkim-atps=neutral
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	by in32.mail.ovh.net (Postfix) with ESMTPS id 4QZbyd3YSRz2Dq2GF
	for <contact29-return-1-linux-kernel=vger.kernel.org@institut-mingmen.fr>; Mon,  5 Jun 2023 14:46:17 +0000 (UTC)
Received: by lindbergh.monkeyblade.net (Postfix)
	id 1702FF7; Mon,  5 Jun 2023 07:46:09 -0700 (PDT)
Date: Mon,  5 Jun 2023 07:46:09 -0700 (PDT)
From: MAILER-DAEMON@lindbergh.monkeyblade.net (Mail Delivery System)
Subject: Undelivered Mail Returned to Sender
To: contact29-return-1-linux-kernel=vger.kernel.org@institut-mingmen.fr
Auto-Submitted: auto-replied
MIME-Version: 1.0
Content-Type: multipart/report; report-type=delivery-status;
	boundary="CC6E2FD.1685976369/lindbergh.monkeyblade.net"
Message-Id: <20230605144609.1702FF7@lindbergh.monkeyblade.net>
X-OVH-Remote: 23.128.96.19 (lindbergh.monkeyblade.net)
X-Ovh-Tracer-Id: 17670154613071447430
X-VR-SPAMSTATE: BOUNCE
X-VR-SPAMSCORE: 10000
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelledgkeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucfpohhtihhfihgtrghtihhonhculddutddttddtmdenucfjughrpeffhffuvfggtgesphdttdertddtvdenucfhrhhomhepofetkffngfftqdfftefgoffqpfeslhhinhgusggvrhhghhdrmhhonhhkvgihsghlrgguvgdrnhgvthculdforghilhcuffgvlhhivhgvrhihucfuhihsthgvmhdmnecuggftrfgrthhtvghrnhephfevueetuddvteelhfehjedtveeufedvkeevkedvgedugedvvedujeeuheduuedvnecuffhomhgrihhnpehmohhnkhgvhigslhgruggvrdhnvghtrdhimhenucfkphepvdefrdduvdekrdeliedrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdefrdduvdekrdeliedrudelpdhmrghilhhfrhhomhepoeeqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptghonhhtrggtthdvledqrhgvthhurhhnqdduqdhlihhnuhigqdhkvghrnhgvlhepvhhgvghrrdhkvghrnhgvlhdrohhrghesihhnshhtihhtuhhtqdhmihhnghhmvghnrdhfrhdpoffvtefjohhsthepvhhrgeegpdgukhhimhepphgrshhspdhrvghvkffrpehlihhnuggsvghrghhhrdhmohhnkhgvhigslhgruggvrdhnvght
X-Ovh-Spam-Status: OK
X-Ovh-Spam-Reason: vr: BOUNCE; dkim: disabled; spf: disabled
X-Ovh-Message-Type: BOUNCE

This is a MIME-encapsulated message.

--CC6E2FD.1685976369/lindbergh.monkeyblade.net
Content-Description: Notification
Content-Type: text/plain; charset=us-ascii

This is the mail system at host lindbergh.monkeyblade.net.

I'm sorry to have to inform you that your message could not
be delivered to one or more recipients. It's attached below.

For further assistance, please send mail to postmaster.

If you do so, please include this problem report. You can
delete your own text from the attached returned message.

                   The mail system

<linux-kernel@vger.kernel.org>: host 23.128.96.18[23.128.96.18] said: 550 5.7.1
    Content-Policy reject msg: The message contains HTML subpart, therefore we
    consider it SPAM or Outlook Virus.  TEXT/PLAIN is accepted.! BF:<S
    0.999997>; S229489AbjFEOqI (in reply to end of DATA command)

--CC6E2FD.1685976369/lindbergh.monkeyblade.net
Content-Description: Delivery report
Content-Type: message/delivery-status

Reporting-MTA: dns; lindbergh.monkeyblade.net
X-Postfix-Queue-ID: CC6E2FD
X-Postfix-Sender: rfc822; contact29-return-1-linux-kernel=vger.kernel.org@institut-mingmen.fr
Arrival-Date: Mon,  5 Jun 2023 07:46:01 -0700 (PDT)

Final-Recipient: rfc822; linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel@vger.kernel.org
Action: failed
Status: 5.7.1
Remote-MTA: dns; 23.128.96.18
Diagnostic-Code: smtp; 550 5.7.1 Content-Policy reject msg: The message
    contains HTML subpart, therefore we consider it SPAM or Outlook Virus.
    TEXT/PLAIN is accepted.! BF:<S 0.999997>; S229489AbjFEOqI

--CC6E2FD.1685976369/lindbergh.monkeyblade.net
Content-Description: Undelivered Message Headers
Content-Type: text/rfc822-headers

Return-Path: <contact29-return-1-linux-kernel=vger.kernel.org@institut-mingmen.fr>
X-Greylist: delayed 4198 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Jun 2023 07:46:01 PDT
Received: from 5.mo586.mail-out.ovh.net (5.mo586.mail-out.ovh.net [188.165.36.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6E2FD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:46:01 -0700 (PDT)
Received: from mx1.ovh.net (unknown [10.110.171.142])
	by mo586.mail-out.ovh.net (Postfix) with SMTP id BB8A6202E9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 11:07:32 +0000 (UTC)
Received: from localhost (HELO queueml) (127.0.0.1)
	by localhost with SMTP; 5 Jun 2023 13:06:48 +0200
Mailing-List: contact contact29-help@institut-mingmen.fr; run by ezmlm
Precedence: bulk
X-No-Archive: yes
List-Post: <mailto:contact29@institut-mingmen.fr>
List-Help: <mailto:contact29-help@institut-mingmen.fr>
List-Unsubscribe: <mailto:contact29-unsubscribe@institut-mingmen.fr>
List-Subscribe: <mailto:contact29-subscribe@institut-mingmen.fr>
Delivered-To: mailing list contact29@institut-mingmen.fr
Delivered-To: moderator for contact29@institut-mingmen.fr
Received: from localhost (HELO queue) (127.0.0.1)
	by localhost with SMTP; 5 Jun 2023 13:06:28 +0200
Received: from unknown (HELO output34.mail.ovh.net) (192.168.13.87)
  by 192.168.9.18 with AES256-GCM-SHA384 encrypted SMTP; 5 Jun 2023 13:06:28 +0200
Received: from vr35.mail.ovh.net (unknown [10.101.8.35])
	by out34.mail.ovh.net (Postfix) with ESMTP id 4QZW502BfYzTMnZMs
	for <contact29@institut-mingmen.fr>; Mon,  5 Jun 2023 11:06:28 +0000 (UTC)
Received: from in32.mail.ovh.net (unknown [10.101.4.32])
	by vr35.mail.ovh.net (Postfix) with ESMTP id 4QZW500BVsz3Ksy0q
	for <contact29@institut-mingmen.fr>; Mon,  5 Jun 2023 11:06:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=46.105.57.200; helo=7.mo561.mail-out.ovh.net; envelope-from=info@institut-mingmen.fr; receiver=contact29@institut-mingmen.fr 
Authentication-Results: in32.mail.ovh.net; dkim=none; dkim-atps=neutral
Received: from 7.mo561.mail-out.ovh.net (7.mo561.mail-out.ovh.net [46.105.57.200])
	by in32.mail.ovh.net (Postfix) with ESMTPS id 4QZW4z6s96z2DnqHV
	for <contact29@institut-mingmen.fr>; Mon,  5 Jun 2023 11:06:27 +0000 (UTC)
Received: from director9.ghost.mail-out.ovh.net (unknown [10.109.146.106])
	by mo561.mail-out.ovh.net (Postfix) with ESMTP id BE045280C1
	for <contact29@institut-mingmen.fr>; Mon,  5 Jun 2023 11:06:27 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-fknqs (unknown [10.109.146.209])
	by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 64D761FE48
	for <contact29@institut-mingmen.fr>; Mon,  5 Jun 2023 11:06:26 +0000 (UTC)
Received: from institut-mingmen.fr ([37.59.142.109])
	by ghost-submission-6684bf9d7b-fknqs with ESMTPSA
	id PyuMEbLBfWSyAg8AJNpUsQ
	(envelope-from <info@institut-mingmen.fr>)
	for <contact29@institut-mingmen.fr>; Mon, 05 Jun 2023 11:06:26 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-109S00383631d16-11c3-483a-8b74-7bf727858074,
                    E5EE630566390D91EACAC72814F3E2251F827395) smtp.auth=info@institut-mingmen.fr
X-OVh-ClientIp:31.33.134.5
From: <info@institut-mingmen.fr>
To: <contact29@institut-mingmen.fr>
References: <01df01d96ddb$8d041260$a70c3720$@institut-mingmen.fr>      <00f401d9834b$1f836170$5e8a2450$@institut-mingmen.fr>      <022601d9840f$6c7da610$4578f230$@institut-mingmen.fr>          
In-Reply-To: 
Date: Mon, 5 Jun 2023 13:06:24 +0200
Message-ID: <019e01d9979d$c50a5a70$4f1f0f50$@institut-mingmen.fr>
MIME-Version: 1.0
Content-Type: multipart/related;
	boundary="----=_NextPart_000_019F_01D997AE.8897E560"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHoS/JIcvuPTynWqFhf1gsExGLsyAHEylOuAkF9uLcCBGpEL68uTbXQ
Content-Language: fr
X-Ovh-Tracer-Id: 13957499672468158019
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelledgfeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfhfjgfufffkgggtofhtsehrtdhgpedvtddunecuhfhrohhmpeeoihhnfhhosehinhhsthhithhuthdqmhhinhhgmhgvnhdrfhhrqeenucggtffrrghtthgvrhhnpeetieehteegjeevueefvdekveevleegieetfefgieeivdevkeehuefhgffggfetvdenucffohhmrghinhepihhnshhtihhtuhhtqdhmihhnghhmvghnrdhfrhenucfkphepuddvjedrtddrtddruddpfedurdeffedrudefgedrhedpfeejrdehledrudegvddruddtleenuceurggutfgvphhuthfgmhgrihhlpehinhhfohesihhnshhtihhtuhhtqdhmihhnghhmvghnrdhfrhdpuhhnshhusghstghrihgsvgesihhnshhtihhtuhhtqdhmihhnghhmvghnrdhfrhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehinhhfohesihhnshhtihhtuhhtqdhmihhnghhmvghnrdhfrheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptghonhhtrggtthdvleesihhnshhtihhtuhhtqdhmihhnghhmvghnrdhfrhdpoffvtefjohhsthepmhhoheeiuddpmhhouggvpehsmhhtphhouhht
X-OVH-Remote: 46.105.57.200 (7.mo561.mail-out.ovh.net)
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelledgfeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfhfjgfufffkgggtofhtsehrtdhgpedvtddunecuhfhrohhmpeeoihhnfhhosehinhhsthhithhuthdqmhhinhhgmhgvnhdrfhhrqeenucggtffrrghtthgvrhhnpeetieehteegjeevueefvdekveevleegieetfefgieeivdevkeehuefhgffggfetvdenucffohhmrghinhepihhnshhtihhtuhhtqdhmihhnghhmvghnrdhfrhenucfkphepgeeirddutdehrdehjedrvddttddpfedurdeffedrudefgedrhedpfeejrdehledrudegvddruddtleenuceurggutfgvphhuthfgmhgrihhlpehinhhfohesihhnshhtihhtuhhtqdhmihhnghhmvghnrdhfrhdpuhhnshhusghstghrihgsvgesihhnshhtihhtuhhtqdhmihhnghhmvghnrdhfrhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeegiedruddthedrheejrddvtddtpdhmrghilhhfrhhomhepoehinhhfohesihhnshhtihhtuhhtqdhmihhnghhmvghnrdhfrheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptghonhhtrggtthdvleesihhnshhtihhtuhhtqdhmihhnghhmvghnrdhfrhdpoffvtefjohhsthepvhhrfeehpdgukhhimhepphgrshhspdhgvghokffrpefhtfdprhgvvhfkrfepjedrmhhoheeiud
 drmhgrihhlqdhouhhtrdhovhhhrdhnvght
X-Ovh-Spam-Status: OK
X-Ovh-Spam-Reason: vr: OK; dkim: disabled; spf: disabled
X-Ovh-Message-Type: OK
Subject: [contact29] =?iso-8859-1?Q?Pensez_la_Sant=E9_autrement...?=
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 20
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelledgfeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucforghilhhinhhgqdfnihhsthdqqdfgiihmlhhmucdlvddtmdenucfjughrpefhvfhfjgffkfggtgfothfusehrtdhgpedvtddunecuhfhrohhmpeeoihhnfhhosehinhhsthhithhuthdqmhhinhhgmhgvnhdrfhhrqeenucggtffrrghtthgvrhhnpeehveevleevuefhledvudekgfelgffftdevueeivdeiveevveelvdeufeehvddtkeenucffohhmrghinhepihhnshhtihhtuhhtqdhmihhnghhmvghnrdhfrhenucfkphepgeeirddutdehrdehjedrvddttddpfedurdeffedrudefgedrhedpfeejrdehledrudegvddruddtleenuceurggutfgvphhuthfgmhgrihhlpehinhhfohesihhnshhtihhtuhhtqdhmihhnghhmvghnrdhfrhdpuhhnshhusghstghrihgsvgesihhnshhtihhtuhhtqdhmihhnghhmvghnrdhfrhenucevlhhushhtvghrufhiiigvpeegheehnecurfgrrhgrmhepihhnvghtpeegiedruddthedrheejrddvtddtpdhhvghlohepjedrmhhoheeiuddrmhgrihhlqdhouhhtrdhovhhhrdhnvghtpdhmrghilhhfrhhomhepoegtohhnthgrtghtvdelqdhrvghtuhhrnhdquddqlhhinhhugidqkhgvrhhnvghlpehvghgvrhdrkhgvrhhnvghlrdhorhhgsehinhhsthhithhuthdqmhhinhhgmhgvnh
 drfhhrqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekiedpmhhouggvpehsmhhtphhouhhtpdhsphhfpehprghsshdpughkihhmpehnohhnvg
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_50,HTML_MESSAGE,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--CC6E2FD.1685976369/lindbergh.monkeyblade.net--

