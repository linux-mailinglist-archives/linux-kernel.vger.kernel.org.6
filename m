Return-Path: <linux-kernel+bounces-334877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2204397DDC6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 18:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21B1282811
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 16:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69585175D39;
	Sat, 21 Sep 2024 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="ElKmbHez"
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D8638DE1;
	Sat, 21 Sep 2024 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726934677; cv=none; b=GNjNyrv8070egu3uSZOrvepFskSIh2an3HzyIRtdmnpxjQtFac2B0fEgsVI01pTPHzumH5V+Gs3oXgSu5qdBaG6SWWg0wd6tAyMN4hGz999fj8Z7J+nsJA5WA6QT7143mgi3y86b440k87gi5uwU+qfo1WySjWfOJJMw5d6S8zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726934677; c=relaxed/simple;
	bh=H5F90rB58uGzcWaFnaZV/LE4qBTOYOpGICqjNo/uK20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aTq4Sgpf2nmBfWzApp4bK1x2zbNgOOVskaW+IC3IhwcNwsaaqVVb4RMKzhvxx/UdnJF0wcZnU6Txi5EvCO4FvCzwjQ0n+6FV5MoAbIt+NrYVnzl23YIy4apB5ox0PfRYlO55ClmPQXhe78dBHJfDmxnHvLoZEavRQKMa8jx5NdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=ElKmbHez; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 62215FC20D6C5;
	Sat, 21 Sep 2024 19:04:18 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id j-VzKUJ4tFvU; Sat, 21 Sep 2024 19:04:18 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 2E6E31F0C6EF;
	Sat, 21 Sep 2024 19:04:18 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 2E6E31F0C6EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1726934658;
	bh=ssdv2fMp3zp3i+dXzmOSC1VQ7A/1Z1y2ZcLf3tqNFl8=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=ElKmbHez+sOVcTWiazVaAXZLkhfoXA8uTxs+i1RDUi7cbPq/zAGGMY7Uaw/QSkOYS
	 NUUDGmGFFVb/B+ci9a7RJ1f+kygaVfk/94Rtv1qxfSGpmJPF1WifpmawfOjrj7JUOG
	 /WT02xFLPUdAnuYTcBoZ39MoXKpbVEgptjvA1PL4AQPcLms5XmzQ076nTaOkMC0vyl
	 6CaVQiOxiVVUmOTxiVkXOSdEwF2UAH9hZtFCw13ximRL7YZAxU9M8XYfYo5gTZOR5u
	 rlhOoxKrKb5f8626OiDeKdtTvN/UxVFHG7Kd9lwmJqF9T1gwJxYbPWkPXqUyCYK2Vn
	 KsX8UwCl3y6HA==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 95v4ZdzvCY0P; Sat, 21 Sep 2024 19:04:18 +0300 (MSK)
Received: from localhost.localdomain (unknown [89.169.48.235])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id 06375FC20D6C5;
	Sat, 21 Sep 2024 19:04:16 +0300 (MSK)
From: Mikhail Lobanov <m.lobanov@rosalinux.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Lobanov <m.lobanov@rosalinux.ru>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Rodolfo Giometti <giometti@linux.it>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] usb: oxu210hp-hcd: Fix double locking of oxu->mem_lock spinlock
Date: Sat, 21 Sep 2024 07:49:12 -0400
Message-ID: <20240921114914.8802-1-m.lobanov@rosalinux.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Initially, the function oxu_qh_alloc() acquired the spinlock oxu->mem_loc=
k,
and then called the function ehci_qtd_alloc(), which also attempted
to acquire the same spinlock. This would lead to a deadlock.

Remove the locking from the function ehci_qtd_alloc(). Now, oxu_qh_alloc(=
)
can call ehci_qtd_alloc() without causing double locking. In all other
cases where ehci_qtd_alloc() is called, acquire the spinlock before the
call, maintaining spinlock locking as in the previous implementation.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b92a78e582b1 ("usb host: Oxford OXU210HP HCD driver.")
Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
---
v1->v2: remove bogus mutex mentioning from commit description and update
the commit message to use spinlock.
link to v1: https://lore.kernel.org/lkml/20240916174326.118495-1-m.lobano=
v@rosalinux.ru/

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

