Return-Path: <linux-kernel+bounces-217228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D604D90AD15
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750282811D1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10553194AFD;
	Mon, 17 Jun 2024 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="nYTQ3F5r"
Received: from out203-205-251-80.mail.qq.com (out203-205-251-80.mail.qq.com [203.205.251.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0ED17FAA4;
	Mon, 17 Jun 2024 11:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718624189; cv=none; b=o70P6rowOmJ2QTTqhMvz5QJ8MsLKxZLXj3npQarWBaOiLpOV2j1ubkDjW662/KskPWxuLqooFP/fXql1vpoZ0Gs040o+F0j+CIZS0COV6/zA4OU3pWtXw0CtaPhbtfUk9BUOHNCU4eztRBuVWjSCAFhpP70jFSugDBOn4Agl41E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718624189; c=relaxed/simple;
	bh=kOUjN3ObfB6MLRRhdOU0QbtDh6rZCZ9HITVr7rHgu/g=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=n6xax4zKhTCOkL5QtKjAnZaq1CipEHEoU/i2k+HEFwuSDv3aDI9wZtE5eOgpQmeYn41ihcBVeNIYuwKiOg6KqIg1jiwPOyT6vyoToIY8fI+QZET+bVvbvdFRFu0cSGTD6j4Kq62dx77T+7frqqUK4rg9f16M9B3+BrIDOxFZfgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=nYTQ3F5r; arc=none smtp.client-ip=203.205.251.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718624184; bh=DVWXar9wxRAjzh+tMMvxBN7PqOspNp1LhCSb77WTeOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nYTQ3F5rsUTG0+SXDedgEMijK20Th3AEPEF3tIY4HmLzLrJHobgg8OGFhRf3mfYwK
	 LARnOAJ14dbqXbESTGR57l2m0qGgedIcc+99b6t/MMcWzq5hTAzUqbVP/gdeKsRsaC
	 Nc9Rfd6E5q4V/fTAcDrmEI1x0po6Vztts7Tzdq+M=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 2643043B; Mon, 17 Jun 2024 19:09:36 +0800
X-QQ-mid: xmsmtpt1718622576t2neii6fc
Message-ID: <tencent_E43E1B2F25E4BA5EBBEC33229E5E1BEB4B08@qq.com>
X-QQ-XMAILINFO: MtZ4zLDUQmWf8BIMzYOceNuUXz0sD/09go9XgjcxS12/HumOM82xhfVcQxJ5BU
	 av21b70FilkRFVUZVupHiRn2LjQcKtaMbuR5pmCpdXC7cvFhr8pPiiP5Nob8dFI7v/eqfhWRhZt7
	 pmne4yS9TIM+NpNrTEDVrmS+I8xP8ZFT6Nv31TJa+vb5uzgx/aFRNxgqNDN6wgpAyhcu6mydJ2CJ
	 bVoqj5F0nkizt67JE34L5dbso7buUId4JYOeKF+/vY/EXfIMHHPbpGB4UHzeTmlgqGqv1jToKfeA
	 DaCRoanCA+MrVTnoMTh4zY90TkkpLhoK8KjoHPsm/vEYGf3gGia/yJjY+wEFfZJMtMdnD+SZVV+J
	 r8UvRCiBBKa1XuxT/ZtWtEgeojW1TwRCYx94WwOYcCUqdYIGqWuhqLDWsXrmMGJuhS5ELB+9Iwfh
	 JpGmQo3rmJ/r566SCBogXYJ9DeF3fTnTghuP2xhRzsPFybRkBbHCQC/EwCgDMI1bmr2Wwgu5b1DN
	 j1Iw2gqLN8vQ0Q145BL5G5tcQ/t63YZKkgX5MCOshaxv3mEDyvWrMOZCf7nBg8ipo6CHDsysVjYf
	 z1jJ3Cp7BiszyqhJ9pIL+GEsbqpRYJJ7Ps4C4ipK/2I2R9XkFVKYQgbopZ4YZAVr+PcNhWdy1GWb
	 Fh9llGFvvqXGW9jEGOCZv/Jrvcefu2xkNewRrf+/pQJZHKDh6XJfmdVtzjQT5X60xZJaDA75oMRr
	 rP21m/mnyFuqfJJEiq6JraU1hTBkEuP4tBxVEu7WE30zO7nbJK4Z0UHeuvUvNzex5+O/O0/qmwHa
	 OoZ2qx+F7SPnECx6CrY5yPfgPS4zCxMK8JdkKkvnLDIxDngCT4tieFY6o1TjtIEdwIubw+4M376u
	 7qdfCaH7fOdkU3hKSxiAoCkcMgWC3fp+zIOpgwTaCY86VKxYKi6ekGkojKcBmv+yUnup54HBinD+
	 9rvt28BIBjQCiFSPrTfA==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: pmenzel@molgen.mpg.de
Cc: davem@davemloft.net,
	eadavis@qq.com,
	edumazet@google.com,
	johan.hedberg@gmail.com,
	kuba@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com,
	marcel@holtmann.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	william.xuanziyang@huawei.com
Subject: [PATCH v2] Bluetooth: Ignore too large handle values in BIG
Date: Mon, 17 Jun 2024 19:09:37 +0800
X-OQ-MSGID: <20240617110936.669544-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f3ae861f-d030-47c6-9eec-5a197b875e0b@molgen.mpg.de>
References: <f3ae861f-d030-47c6-9eec-5a197b875e0b@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_le_big_sync_established_evt is necessary to filter out cases where the
handle value is belonging to ida id range, otherwise ida will be erroneously
released in hci_conn_cleanup.

Fixes: 181a42edddf5 ("Bluetooth: Make handle of hci_conn be unique")
Reported-by: syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b2545b087a01a7319474
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/bluetooth/hci_event.c | 4 +++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a487f9df8145..3966fbc38df9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6893,6 +6893,10 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 
 		bis = hci_conn_hash_lookup_handle(hdev, handle);
 		if (!bis) {
+			if (handle > HCI_CONN_HANDLE_MAX) {
+				bt_dev_dbg(hdev, "ignore too large handle %u", handle);
+				continue;
+			}
 			bis = hci_conn_add(hdev, ISO_LINK, BDADDR_ANY,
 					   HCI_ROLE_SLAVE, handle);
 			if (IS_ERR(bis))
-- 
2.43.0


