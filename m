Return-Path: <linux-kernel+bounces-331971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C020897B381
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F391B2AF41
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E223417C99B;
	Tue, 17 Sep 2024 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="k3oorYNj"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9435417A918
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726593603; cv=none; b=mN6SQzdPqLP6GrM+7VEdkJ3sKLpv1mVBJEh75n6+Zg4I4COmj3MSQKFEfthHEn9dBRZ+EWaCqnzhAuTEwSHxr7vGLirR53/gU/XkYkqioB7lA0efmlSjIgBOePZZn+RP0v9tJP0muo1+Y+Iv6w33uOSB+k7/ztqhRBNPlMJfNqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726593603; c=relaxed/simple;
	bh=7JftDz2CnNgd4am1zeQR1JBvyWMCNry1ukM0wjbewWw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=biGk4cRVidZJKfY6GwLpZ4gvJQX2JfvwG297a/53zvbirxXJabwFmNRQu93COdRPF7vPByaoZm8Qf5BeJOftipWNhW5w1V1FKuBiNGG4TIyJBJWO8c4jPy0IBg/iLO1kpb4yKoDrqPLRXBbQdzivj10/47e5F+MI0E/I/IZbMjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=k3oorYNj; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726593599; x=1726852799;
	bh=7JftDz2CnNgd4am1zeQR1JBvyWMCNry1ukM0wjbewWw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=k3oorYNjDhRV+uFUX0A0vY2NjgeJkm6RdFerVG98pkZys8STznhLSbuBItAHlkdUA
	 733KPVi59MOIvqP6Yem4GP1841dE4UUUANZQc3R9TUdX21e8PXqt/IeTvMMQkA8CD2
	 Co5kwe5C2Vt5cUWB0n+JvyRaHHLXZGR8MSPHQNrvAwQomRiaZWZ4ygJbHEPwGgLs6V
	 +thdE+B6/xxSm5d/jTN9kE2tDXxEJ1DJEXG5B4vBCkl+06Idqp96qVm+wMvt1Uts2U
	 g14h9N7RY6r0R68/x4uLqE22HnMNWNrvjHuRFO5f1N783ggSuXlEgbaEfB6W7BaKBf
	 X0BHOFcLMqyUQ==
Date: Tue, 17 Sep 2024 17:19:55 +0000
To: philipp.g.hortmann@gmail.com, gregkh@linuxfoundation.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH] staging: vt6656: Update maintainer in TODO
Message-ID: <20240917171937.22801-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 0a72809504cc8cbb5ebc214030636cd75ac3658e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Commit ed394dbf5371b03a5335a7ba1973ba124c0ced3d replaced Forest Bond
with Philipp Hortmann as vt665X maintainer in MAINTAINERS, but
drivers/staging/vt6656/TODO was not changed, rendering it stale. This
patch fixes it.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/vt6656/TODO | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vt6656/TODO b/drivers/staging/vt6656/TODO
index 876cdccb6948..f536b2efe9a6 100644
--- a/drivers/staging/vt6656/TODO
+++ b/drivers/staging/vt6656/TODO
@@ -15,4 +15,4 @@ TODO:
 - integrate with drivers/net/wireless
=20
 Please send any patches to Greg Kroah-Hartman <greg@kroah.com>
-and Forest Bond <forest@alittletooquiet.net>.
+and Philipp Hortmann <philipp.g.hortmann@gmail.com>.
--=20
2.34.1



