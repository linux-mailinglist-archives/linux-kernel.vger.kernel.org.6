Return-Path: <linux-kernel+bounces-330995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3D497A701
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8881DB2A11A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B4F15C122;
	Mon, 16 Sep 2024 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="HW28dNXn"
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D00715B15D;
	Mon, 16 Sep 2024 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726508679; cv=none; b=fx3+0G4uRavU0iWdgC1vytnXv8cLQe1lXWsQxP39QYJz2mW2ODsqYGuQwmeRtSMOen4umJLuJoDZHSks3fLqk3IOg0Jwha2l0dPJILCrhAl3eomndI/FEhk5/u4dty1wHkOv+um24wJoyDmIyt7TKTTzVuW++iMmgyQ+VslK3Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726508679; c=relaxed/simple;
	bh=7eDBuMMs0mlTHLqH0fVSQqVOeXgOKA1sjzjcFIi40mU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oNrIED96hF/9K+Jm0XswP2i/HHiHc4KUz3MdoYtIevbuc9RDVI/wm7GYWhtq0wpXVA0TcVANdz3zi1osROlJ+KQl5l7cO/a9mKtouJt4IZxuxI8PaX/daGn4eXE2luPpScwJFojiPKYvXqTwSwFy7tq6oFQLZbAGXsMBTNvOwYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=HW28dNXn; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 5071BD14EF857;
	Mon, 16 Sep 2024 20:44:17 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id PSQ_o_-AobwE; Mon, 16 Sep 2024 20:44:17 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 18B6718E21AED;
	Mon, 16 Sep 2024 20:44:17 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 18B6718E21AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1726508657;
	bh=qOB3xh8nGjzty8DVpua/9HXgPIX+Io0reCiMDGNOKvU=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=HW28dNXnHOK0SjHEW1SakYhZ2AfhlSQvyW8QryAEgY0yPhfz5QxS5rrTOdb+/pKnW
	 LqYsNKu8afp4nrPhsqrhv111jyGmPkvfuda/qarYPoD8e5irARpyYJ7Wh2+68Qbe5W
	 0UPwKPCGs57Diic50SR/3NDKpth5ihx55tK5dRp8mdAjzr4ylMD/lbvoq5txigy2yK
	 R1BIqEZOy3SpJa3+mvk9St1C64liCpSnyc2VSKp5PJkHIhz9ALHiESui2XoKnL+XJV
	 cx5PPlqc+Ir/cyeSWDwqQJlJHu0HFS1tZc/BullHwaX0uQUj2U2JIkxcu88iqLjX5c
	 8vtErodA5eYpw==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id c7HbeZwtLCZZ; Mon, 16 Sep 2024 20:44:17 +0300 (MSK)
Received: from localhost.localdomain (unknown [89.169.48.235])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id D580BF9658E77;
	Mon, 16 Sep 2024 20:44:16 +0300 (MSK)
From: Mikhail Lobanov <m.lobanov@rosalinux.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Lobanov <m.lobanov@rosalinux.ru>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Rodolfo Giometti <giometti@linux.it>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] usb host: Fix double locking of mutex 'oxu->mem_lock' in 'oxu_qh_alloc()'
Date: Mon, 16 Sep 2024 13:43:25 -0400
Message-ID: <20240916174326.118495-1-m.lobanov@rosalinux.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Initially, the function oxu_qh_alloc() acquired the mutex oxu->mem_lock,
and then called the function ehci_qtd_alloc(), which also attempted
to acquire the same mutex. This led to potential deadlocks.

Remove the locking from the function ehci_qtd_alloc(). Now, oxu_qh_alloc(=
)
can call ehci_qtd_alloc() without causing double locking. In all other
cases where ehci_qtd_alloc() is called, acquire the mutex before the call=
,
maintaining mutex locking as in the previous implementation.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b92a78e582b1 ("usb host: Oxford OXU210HP HCD driver.")
Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
---
 drivers/usb/host/oxu210hp-hcd.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-=
hcd.c
index 3f871fe62b90..fa24cf89dadb 100644
--- a/drivers/usb/host/oxu210hp-hcd.c
+++ b/drivers/usb/host/oxu210hp-hcd.c
@@ -977,8 +977,6 @@ static struct ehci_qtd *ehci_qtd_alloc(struct oxu_hcd=
 *oxu)
 	int i;
 	struct ehci_qtd *qtd =3D NULL;
=20
-	spin_lock(&oxu->mem_lock);
-
 	for (i =3D 0; i < QTD_NUM; i++)
 		if (!oxu->qtd_used[i])
 			break;
@@ -997,8 +995,6 @@ static struct ehci_qtd *ehci_qtd_alloc(struct oxu_hcd=
 *oxu)
 		oxu->qtd_used[i] =3D 1;
 	}
=20
-	spin_unlock(&oxu->mem_lock);
-
 	return qtd;
 }
=20
@@ -1601,7 +1597,9 @@ static struct list_head *qh_urb_transaction(struct =
oxu_hcd *oxu,
 	/*
 	 * URBs map to sequences of QTDs: one logical transaction
 	 */
+	spin_lock(&oxu->mem_lock);
 	qtd =3D ehci_qtd_alloc(oxu);
+	spin_unlock(&oxu->mem_lock);
 	if (unlikely(!qtd))
 		return NULL;
 	list_add_tail(&qtd->qtd_list, head);
@@ -1630,7 +1628,9 @@ static struct list_head *qh_urb_transaction(struct =
oxu_hcd *oxu,
 		/* ... and always at least one more pid */
 		token ^=3D QTD_TOGGLE;
 		qtd_prev =3D qtd;
+		spin_lock(&oxu->mem_lock);
 		qtd =3D ehci_qtd_alloc(oxu);
+		spin_unlock(&oxu->mem_lock);
 		if (unlikely(!qtd))
 			goto cleanup;
 		qtd->urb =3D urb;
@@ -1686,7 +1686,9 @@ static struct list_head *qh_urb_transaction(struct =
oxu_hcd *oxu,
 			break;
=20
 		qtd_prev =3D qtd;
+		spin_lock(&oxu->mem_lock);
 		qtd =3D ehci_qtd_alloc(oxu);
+		spin_unlock(&oxu->mem_lock);
 		if (unlikely(!qtd))
 			goto cleanup;
 		if (likely(len > 0)) {
@@ -1724,7 +1726,9 @@ static struct list_head *qh_urb_transaction(struct =
oxu_hcd *oxu,
 		}
 		if (one_more) {
 			qtd_prev =3D qtd;
+			spin_lock(&oxu->mem_lock);
 			qtd =3D ehci_qtd_alloc(oxu);
+			spin_unlock(&oxu->mem_lock);
 			if (unlikely(!qtd))
 				goto cleanup;
 			qtd->urb =3D urb;
--=20
2.43.0


