Return-Path: <linux-kernel+bounces-413377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228B89D1857
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A37F4B23363
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029171E47D7;
	Mon, 18 Nov 2024 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fn2N1idl"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29461E1027
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731955406; cv=none; b=N8FiSttTFVPHg4376fXKipHGMOImkLDOfUR4zxKUAtnmn+YlsRWnH4eeuiLt94ssGGGyme9H64hFA1gLV0RZ4BoiDymY33rpuuT34MxjUTaZQAilmBcxZ3rafTF7gkML9N/rjnM0A6IYcc23Mpk3j8i03H1Jh7mr0ihjWNcgmjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731955406; c=relaxed/simple;
	bh=KCcQhPVz6PUxTkptUubEsPv0X3QW8k3JN+SJqqNicp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=be8ZVpWV2X7stOgcV/kg2Ws6FCHLDB1cNtNZbwBlYeGcs+GXzi10ylE/d3YMTI3tsRJqeMchfIytHRvcUeKrysX+5snkmcYpl9ExpCswJIigJoFT135Wq680f7QeJ3I7gIxGym27rp2Twx5uTzZEPS+ka7SXbduvm+0x+mst8Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fn2N1idl; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1FE361BF208;
	Mon, 18 Nov 2024 18:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731955403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LyuZSeQhWN8yZC/+93Agwlt6oIM4sNXPX8BuSmxPT1g=;
	b=Fn2N1idlukmyO71g/GBJznytqRX2mHPvRxWrZnkaPkJcO3bca56ePwok9cl5XkgGQu4yEt
	7d8oSPy7A6Cj625Gs/OspwqEP+dJ3cbL5rIh121vmAa7ru7eDEhc6F2lEaMwfjH0t9uyNC
	nJ9ZjwRro+wXrpy4vnl6QIynERHrgqfe5keOh6kqLslNVcor0LEHZmnADNO93ewiQbrMf0
	R7F8WsWOMGqP30gUTZggg6gJUMnPvhkDCQ0YlQtq1pwZZ2VuJlA+y2JUKEe+PiO2teR/ub
	gDBj68OqKkis/FDUqsxH029/1PPkgr4h7EutvPISRFdc8gSandAFG3a2ZLHXZg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 18 Nov 2024 19:43:16 +0100
Subject: [PATCH v13 3/7] drm/vkms: Drop YUV formats TODO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-yuv-v13-3-ac0dd4129552@bootlin.com>
References: <20241118-yuv-v13-0-ac0dd4129552@bootlin.com>
In-Reply-To: <20241118-yuv-v13-0-ac0dd4129552@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, rdunlap@infradead.org, 
 arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>, 
 pekka.paalanen@haloniitty.fi, Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com, 
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=937;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=iDZ/HJ7Gex8d9aGNH0HIIVbXcYQeibofjLc/H+dZBcg=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnO4rEbq/nLWfL1OQUs3buDRzlKKkI6fbaXdC5I
 ubtYOeAjFeJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZzuKxAAKCRAgrS7GWxAs
 4kLpEACgu0VeMHjosh8+2D15PqD86N9fZXtF0j8+Jzqwyb/HafWMef0r2oNcFXfGmeuU6Z3kt3C
 Pqq1RMvuBhNk2OBE0sraz34N74xSYrXxL8tihN4mdJWaQi3LUGFYsSOE22QbDw11AZ+SYSIBt+T
 Kbz1+L3tVHWG8Dam+1cz5BFNRu4M246xM1iuGV57wIV0ECzk1Z5QjR91/5hMfdGa2+AsyNMHszM
 TSWoC3p9/0J+naA0i9LjVC7bNlqIe0sjKPfDb+UfPFUdX1Ce5sS1dSmPXra+iMjd+vqp+35rzaH
 CQwafIcSmXCFPZItTk5j43vB1qArwZ93JjLXOOTDFpPiyAuC2fQcYc7y5oncVlm+ogpx6q3jvhP
 zIXKpd4Ueg9Bsk//c5r8Fh8VsiVFqFNbV5YP3br7eVDr7AhoPCsnC8ZW2jZcHgit2WGApft3LgZ
 bog69t39IiLpH6YqSNtzmV3VqLms9rUz9aDwPzFRVHYXAsR2I+ZlvEJ3yoAljKctT9+E150vnOY
 BEQiYQDHxKdBoKcyRN5WxXXswx7ziiAsqXqQ3MTULip7G+yY2j5bHcLWJQfPtVeXNuWciMj6EHP
 UQ6801yhmSltFIj3Hp3gdoc6SHS7kx7nU1uo1jf2EfkJbJS7DBgKWumQW4WP1bUMQREUDfvhaD5
 lyckCgWT9i+2jeA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

From: Arthur Grillo <arthurgrillo@riseup.net>

VKMS has support for YUV formats now. Remove the task from the TODO
list.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/gpu/vkms.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index ba04ac7c2167a9d484c54c69a09a2fb8f2d9c0aa..13b866c3617cd44043406252d3caa912c931772f 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -122,8 +122,7 @@ There's lots of plane features we could add support for:
 
 - Scaling.
 
-- Additional buffer formats, especially YUV formats for video like NV12.
-  Low/high bpp RGB formats would also be interesting.
+- Additional buffer formats. Low/high bpp RGB formats would be interesting.
 
 - Async updates (currently only possible on cursor plane using the legacy
   cursor api).

-- 
2.47.0


