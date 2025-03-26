Return-Path: <linux-kernel+bounces-577662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220A1A71FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 21:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB473B8AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCC8254849;
	Wed, 26 Mar 2025 20:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="CLCaIJ5s"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FF41E4AE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743020443; cv=none; b=qmmXI8w+y/+Xa72SFIusXBQfZLYDZ/oJlIFs2Zmyxoz0+70ziMzDpPA7ADhCNvD2P0W64S8RHRERBCWRNqgxxBVtrDcjmtmqF1lvX2ZPBBunEST3WrC0/P2I7QlWlMELmn3SsC9sQ6NHb/cMiAKSNrlH7kYzWRTgQu6k7qCh6Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743020443; c=relaxed/simple;
	bh=bA6aMpwHssxMigWUXPdk4kvnyqyEeNbtxmQzXs5iQyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Vim1s5AmrrupVZrBKCHSZJJoKT/P1+XEPjPYlv9J+TzumHQ93SBxq4Dg8OBhzGmUhnE0q+XneZX/fBxH4Ktp6dcsFhsi/eU8VdHbC7IntzYgATekaU2GFSwBakz3iwbTKgqbwX6Y/M92g4mA5kDuQRpLwnQjYUEoMN9HpUOJGYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=fjasle.eu; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=CLCaIJ5s; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fjasle.eu;
	s=ds202307; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Sender:Reply-To:Subject:Date:Message-ID:
	To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=21ntidzPPrQ9MtwEr/MFbf09lKJvgXCezyq4in08maM=; b=CLCaIJ5sXmiUHY7Nx/Eg1JSeEp
	P37BzC6VOWqhZCMDlCvUKFpeD9X/X1Q9KTXl/4XwUDk9pIYOt84SVQv+WR2uwuTew5MRDo7ll5B+y
	UCQ/6q6+WINQ9Z5puKmqIOy80ZkwZWMriiijYTM54S1aMoaVy3knPFC5YTFrkqVyJ4tWy15vkWafl
	KvZ9UiRjMGHunfJuhAhLHy8G9tjt4jdll/ZiqK8NxNiWO40PybM7n6sCqMVOTvh0PAHQFEfIJr/aP
	bO6imdVQTwIwSqbu8D4rxTmyzrClUbOrBxhg4lJGqESfM7F3yfs3ozXYhPwhpla7vFcMp4eCa01vj
	HZBZ1S3g==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1txX8U-004BZq-F0;
	Wed, 26 Mar 2025 21:14:02 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
Date: Wed, 26 Mar 2025 21:13:55 +0100
Subject: [PATCH] mailmap: Add an entry for Nicolas Schier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250326-mailmap-add-entry-for-nicolas-v1-1-3c26579a7fdf@fjasle.eu>
X-B4-Tracking: v=1; b=H4sIAANg5GcC/x3MwQqDMAwA0F+RnBeoFTvwV8RDZtItoK2kQybiv
 1t2fJd3QhFTKTA0J5jsWjSnivbRwPyh9BZUrgbvfO86H3AlXVbakJhR0tcOjNkw6ZwXKiiRXey
 7EJ4vhnpsJlF//3+crusG5ZRdk28AAAA=
X-Change-ID: 20250326-mailmap-add-entry-for-nicolas-efd0f53667bd
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Nicolas Schier <nicolas.schier@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1183; i=nicolas@fjasle.eu;
 h=from:subject:message-id; bh=bA6aMpwHssxMigWUXPdk4kvnyqyEeNbtxmQzXs5iQyI=;
 b=owEBbQKS/ZANAwAIAQdSCnAWJhJpAcsmYgBn5GAJC1xIsSGy4dkWF698kKeC0aFOrIR3dHAd8
 DOuExJcRdmJAjMEAAEIAB0WIQSHQTenhzckp4G+wsYHUgpwFiYSaQUCZ+RgCQAKCRAHUgpwFiYS
 aS/5EACLUpFHT+LsBv0Ln+vY6UIC0f3UfOQDfNFqN7h1Z2EGcWbM2hvT4GMzp/mIO8vzUfeHcz0
 vDk6yIPhpMxPFgXDeYqHIFPI+FKsDfVGRU+NHL3gxOEOkaY2pyn7ZcS0BecuMq3iJSSeCeVlNeR
 zF2lNux0t7Sn38tZg8WY9+b72rQ/LehDVW50ZJ9Lkv8NUr/pwNZ+9cCpblUIga0un4B1MP8b3Jn
 o8dHv6MLx85HvSy/6yjYsK5/6m7+R96ta9Ci11GNGa2CSN6xUDmiiQ/rxvHka+imbXkwQl00Pof
 11WG2KcYKIGhrTyViIi1zYob18etGhHIsVdtC8RFu3G/LYJkaO31uc2axLpstCMXxViAaBHcCuC
 wfsQmhQxN1XtGtJD7spLOlrwrXk7iISx8UNmGSGORWP5PArRpr6+sOz8mbAeQ5IMHroo8UMnPX8
 p+1c48LDnkITMne47ZOWeZEUJVkWzM9qoRvvVcZehgEwS7ybWSpXYOLqEscfMZnNGmC6qfPvIfT
 xfH0XYsMGsogjCb9YgfdGtrjXe+m26pq68GqdV42YFH1yUP0fkbbiJ8UHDFX1ZMx1R5xs8LQPbn
 c8MxHy18VcCkln29JzE0j3C704o0Y8KcXv+VrLpLilnw4K3wlbS0H3DN2q0bKL2DEpk21jzDDBY
 ZJO+qjymF1VkD/w==
X-Developer-Key: i=nicolas@fjasle.eu; a=openpgp;
 fpr=18ED52DBE34F860EE9FBC82B7D97093255A0CE7F

Add mapping to linux.dev address as mail usage at work is limited and my
mail provider for private mails is suffering from its own domain name
block lists.

Signed-off-by: Nicolas Schier <nicolas@fjasle.eu>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 72bf830e1e588ece83fcaf32a9825f7a2f2d917d..d9f92b1d85ad74dc9f7d49d4f1ee855d0c20d953 100644
--- a/.mailmap
+++ b/.mailmap
@@ -540,6 +540,8 @@ Nicolas Pitre <nico@fluxnic.net> <nicolas.pitre@linaro.org>
 Nicolas Pitre <nico@fluxnic.net> <nico@linaro.org>
 Nicolas Saenz Julienne <nsaenz@kernel.org> <nsaenzjulienne@suse.de>
 Nicolas Saenz Julienne <nsaenz@kernel.org> <nsaenzjulienne@suse.com>
+Nicolas Schier <nicolas.schier@linux.dev> <n.schier@avm.de>
+Nicolas Schier <nicolas.schier@linux.dev> <nicolas@fjasle.eu>
 Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
 Nikolay Aleksandrov <razor@blackwall.org> <naleksan@redhat.com>
 Nikolay Aleksandrov <razor@blackwall.org> <nikolay@redhat.com>

---
base-commit: 2c8725c1dca3de043670b38592b1b43105322496
change-id: 20250326-mailmap-add-entry-for-nicolas-efd0f53667bd

Best regards,
-- 
Nicolas


