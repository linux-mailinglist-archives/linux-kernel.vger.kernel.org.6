Return-Path: <linux-kernel+bounces-348039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4595698E1DB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DC52867D0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A371D1743;
	Wed,  2 Oct 2024 17:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pQQYn6OG"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417EB18052;
	Wed,  2 Oct 2024 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727891339; cv=none; b=RdWuPiwz0AYnYHgdZdmn9lpilS26FUJpfiFokbUOISiEP/vkE2r4NsKmKpxr7fgLsQ+zdlbxrDSbrZmxJx9m2Gl0BQQ4uO617KguIhaA1jC+oNoP6ir4xmXjTn1IKz8hKnzZcETlrmYcLCd73BLYX5mLHEGqqI4jDpi3CabqztI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727891339; c=relaxed/simple;
	bh=DinzFEMHGAFY7kxCmwW6Pz2NOsyaASUqK0ar0tpl0ao=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mJj4uNrM1sUEvlGrDDlG9slv+wh9ZXCXdB5uczHsff0s+CH0yghJohILxqW9DPjfhzdfSrnUdg3bQCiuNOZvJR2bHpftlat/0uVpRnjTaOgYBEAMFycmtss46S8aH0/xBt1khkMi6K6zcZ76SIFN1X9FLW/VkX3CgSroaeGezh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pQQYn6OG; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727891316; x=1728496116; i=markus.elfring@web.de;
	bh=UdzyMxMYg7gx67lxGGSAjs4dqNY3Sz+XDV+9GjFT7pc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pQQYn6OGZW05p4YIhZwMwfiW2GaOI18myisuc4VIZkKXwG5ZbDb7EkwErVKUSfdv
	 KJJ3D7wy3XfAYRe1Pz6stQ/yshwg4gsRYtdXtskYwNsW9RzmdYmHwVL1ZWsi6v8kB
	 qrT1Cy+DEQI9OePiFW63A2VpJ0mrUMGje/AchxEbKeAIWf9ndlrbM5jvs4o9uijaW
	 +teeZh2nk2QKeay8nohEbsrX0RiYzKzStnhvp4KGeBi2xcWQc9ckfs03HtTuPRRqZ
	 HuGzlM/GfsJqWqa7Hz439vrOWkxVdVBZMnQBRcGj3wftX/1jjlzWU5nn2jmYDxVlt
	 qlPGjZ6duwOc301+RA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mc1ZT-1sJhF50gzX-00bw47; Wed, 02
 Oct 2024 19:48:36 +0200
Message-ID: <ac69dd2e-b4e4-4f70-b6c4-476b92160270@web.de>
Date: Wed, 2 Oct 2024 19:48:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Russell King <linux@armlinux.org.uk>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/2] ARM: mvebu: Adjustments for common code in two functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4/g1cd+1Y+6AxLFJ7Ock4iHC+jweghLSS3bi3+RXZKer5tb1sIj
 ui7heuFGHq5rlcgcSVmiNe4xqZey2308uSe4fyQQ5o4lryDFz+RkqXgmTa/2CyEFkguACF3
 0AJbVmCVIhx/k34CIk43eSDs0V9jP0pRYu2GHGsKXabjVydVmpm7en92+dI1FbyBNLi49+x
 tSjSYS51N7CkZ0U8sAF1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8brjOrdve00=;rPNprnmRAmHAy8nJldST3i18u94
 QcnD7f58Uh2FcAHPJ/3ulWY9ZSO7014kXvV86kgyZjDq/r7wrzEMn6PGvQAvVJk/vW2J5mWN3
 KRlfjUO+ELt1KGBvDjd3OdqjMomP0q5iijmblWZLZjMUequhQnN618NKRJnOVHxXYyYutdgoL
 pDux3qEhR1ji8BaJnGEl+g6UrT2tpk/g4JymH4xhzIyjqGOPaork40v8+lsLIjlI/sZt8fcmm
 uqUKyrFBUcL6aNej1X0/3KkKc8TcOoivsdQtwjqOoOTYhxI0yMRQlrJ5LR9hYdE5CId2LSviS
 nf4Fybz0j4xOkO5Lnw0KkbHi/doDwDAE5uvjjJ5Rve+0Qw19Lxht6MwgFJLrgvV5lQn9QDsm9
 ieeBkkDyswOeLPCpUJ9GnF86oKpr3VZAsGnLtpRH7N3U7Qk38U5XhOSDmjFQs4rm0w7ZkNEb+
 +aQJMBfWoIOxV/5M5Yno2YeR8/8IColHX02IYw/yil9+6hbbGcAIXp4n5TnktHhUrhdqfisdE
 257ITkX8HRYj+g11I0yFnNjNWQtajux7h9bzdlbNJPwBhuZoh8MLEWzKGsBY0whJXLNzbSu6T
 Bxw/sjb7e9g24jibT3hDDAA/roTcNUelERB+NmqWoNVCF8Kv9MJdd1exaPoKKYyd4UoAj+Yic
 RdZMxc3y01sysXHKJ+UtdaYunel1Aud+ubBSR6XP6yEie2HsTWDUQyzTv4J6KzFT+rhvtX2RY
 RJIP44TyqXCG4cNn6VMQzv6kpzNmZvsxfESLJyawavNbMrpT7J8j4uuoa2LBeKFovHdVWRkQf
 T9v6FqptqqZ1rJEXc7Dw3dbQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 2 Oct 2024 19:32:23 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Call of_node_put(cpu_config_np) only once in armada_370_coherency_init()
  Use common of_node_put() code in mvebu_pm_suspend_init()

 arch/arm/mach-mvebu/coherency.c |  7 ++-----
 arch/arm/mach-mvebu/pm.c        | 21 +++++++++++----------
 2 files changed, 13 insertions(+), 15 deletions(-)

=2D-
2.46.1


