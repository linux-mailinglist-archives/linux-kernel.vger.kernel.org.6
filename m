Return-Path: <linux-kernel+bounces-420393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7559D79E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 03:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2B1282504
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 02:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EC8846F;
	Mon, 25 Nov 2024 02:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="id2bvmbg"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC102624
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 02:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732500073; cv=none; b=pqiCTfhZR2ZspZiFnuf+s1/Y9RP1Cx8446zUQ+5Q8spxjOoY5/5WsRAbBoDsmmffUclrSZdybF4n7wZIiPgv7UBpvt6fzVQcY0WgzE33wExBirlLxTGGNreYUZMVNEfNc7Ike/nzv9yHXjeTj5/C93Pp04pZLw95iw6DKZE9pXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732500073; c=relaxed/simple;
	bh=Imu7tZpTm/lefKmha5PMTMjh2MvOAhnkQJAOOf22eWo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aUxBok9ySZ+yByP9kv/XTZ3FsmgRSnbK93RJp1OOx/j/3R4Qrc9xXIpq4KBEGzy6w+OEIvan8eLeYcCyPYpDXiOdLvf1MbpEe/q5vWlnsG3ul4aepjU2E2NqE2VE0JBaroa3SpM70iEqCQbjzRNGhWDcnYrihYaURnkSyNqH2Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=id2bvmbg; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732500063; x=1733104863; i=efault@gmx.de;
	bh=F0o1tpWKnyPncbvdymvLENTDLgKKwtfdgcM2ZcF7Ov8=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=id2bvmbgL5UZ60DjEFNAMq6M7s6+ao1IUo1At3+DQ5HM/SBBFwdDuvc7hkNJMJbn
	 78ZaTgsuoA0fTbexIFALDQ96v0V40l8rH9214fNPRwktXrpvyWQHEZU4fNuiABc9l
	 Y9cUIKOUTpJZPQSA/XDNsyTQy/SQZ4ykntREGBD7ka7cTnTNLCuJ6kaEDG+UAUCRY
	 He27oO18MO7p6/zvHzsFqKSywiRAjYBqQQoKSss/sMyGeXyoHqRuK/tSgio2yB5II
	 EmcFpAiNJviNmbPg3RZXayQvoSYzew8RX0cZ4qSLtFEr0FTwBFBLiBh5YMZ9NzJnC
	 6Z3Ui4a37kmCqr74AQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.127]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mjj87-1tyeWa2LMJ-00m0fM; Mon, 25
 Nov 2024 03:01:03 +0100
Message-ID: <e3142efe46edaced3e50c1dc1ea99bd970551209.camel@gmx.de>
Subject: Re: [GIT PULL] HID for 6.13
From: Mike Galbraith <efault@gmx.de>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Kosina
	 <jikos@kernel.org>, linux-kernel@vger.kernel.org
Date: Mon, 25 Nov 2024 03:01:02 +0100
In-Reply-To: <ac800b7930c473f2653d9bdc5be0781a08d8bb58.camel@gmx.de>
References: <nycvar.YFH.7.76.2411182207390.20286@cbobk.fhfr.pm>
	 <CAHk-=wiUkQM3uheit2cNM0Y0OOY5qqspJgC8LkmOkJ2p2LDxcw@mail.gmail.com>
	 <ac800b7930c473f2653d9bdc5be0781a08d8bb58.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IPN3czG86w78LxnV6bJCSC4GSanWHJNF0KsrA7CCNvt4hG/dalB
 he0hNWlRuujMjnj+WOnW0N63L9nuOfK8RXsVIJwnRif+PTA4+z0s5kdIsfoz220LSpg+APg
 60ljK79VnIDtwv4mslEM37mzxbli5G+Ntu4EVmMmxSJ+GADUK6/PFsaGr8BWVXH7eqxge0u
 bCqu4qp7NQ5kcCrb3vkNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ua21y9aw5iY=;2oS4DSGIuZkcuDoHUiTLR/izhaf
 uK1p+b/bTYCPbvzhgLVc0ObEXNwoxTnRd9cNuNH7sCfOkl94S27Wu83NF6d8ee7okd+g/71fl
 JKcmO4XUy4F08K4ILhsooa9eVmVOp2Fr804OdhCEySEBcChjnV6bReZ0QdpgJK8Mw+vum+R5A
 1ENmceA9bMBq4Bj05F5zU27R6hyqlJtgZKjhuK18oI6BkANsCRiFdpBXuNrzZkb/u9lRJFPAz
 VHBudT8Dji8rwWdZi61NsWju5IttjFKJewBB7dOTXyDaxqlo9HXgRQrZmNNh1JBaKJJ+OxmPn
 WlvDnjXecm60lzUcWORdnG8usO3WSF+VSqQO8msIqSu5dLyacJjuWUkZlCvaqQfubYaU3ozMa
 NcHrWXHu1Jnna/9aYgEjQuR+sBsu4fW6tDnMMujvvLFGA3NMaEVBWK9k2XD22QNJ6iej14+8e
 jFgTrmBcc2lmiZCVHYN9z9rPJ6s2yykOe53UGRldXDB4Q22pA8/A8Odv1h1ubuwWZNgwV2scp
 /YUyHLDx88idvr7VTDh8XE468fDDR9O1PcqXMrGB84bm0e5iAlL3aLFj9vrlLL+Lur0vbrtBX
 XqewpKdCx/X5kEd7HRID0hLMJ8wlmHiXNbvROBx5cOmjQcHc9Gbb9aKeE5FdEkJfHSTQ/J22a
 XDe2xeU5xqWxKg4nGvb689EnH1nPtoTdwzZV+W/59t/3mTyiQC3L5XMLNWygW+02nd4vSoRsW
 TfHaepCJkgt678OK7b5mPwqxug1x+n1xFH3cK6ltzHf+9WJU6OvsSH3PXpCgvPPt4VgW4o2kW
 ZPmCH2G3y+9X4jWkZua8Y70GnGQW40SGe4r51NE/+yQDSd6jhKmgKTQQQPWjWL4y5nF4w87eU
 MEg2QmHCkMfHCu4mL3jZ6S8aDyL9cbZp+JaWmj3zDJetYjZ5LyFjoE8rl

On Sun, 2024-11-24 at 09:01 +0100, Mike Galbraith wrote:
> On Fri, 2024-11-22 at 12:13 -0800, Linus Torvalds wrote:
> >
> > Any ideas? Does this make anybody go "Hmm, maybe ..."
>
> No, but my M215 had the same issue, it bisected to 6fd47effe92b, and
> revert via patch confirmed it.

Hopefully useful diag.

[    3.769593] hid-generic 0003:046D:C52B.0003: HID-BPF toggled quirks on =
the device: 0800
[    3.892715] hid-generic 0003:046D:C52B.0004: HID-BPF toggled quirks on =
the device: 0800
[    3.895211] hid-generic 0003:046D:C52B.0005: HID-BPF toggled quirks on =
the device: 0800
[    4.193277] hid-generic 0003:046D:401B.0006: HID-BPF toggled quirks on =
the device: 0800
[    4.604769] hid-generic 0003:046D:4016.0007: HID-BPF toggled quirks on =
the device: 0800

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 81d6c734c8bc..3ae0eef2bb9b 100644
=2D-- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2710,6 +2710,18 @@ static int __hid_device_probe(struct hid_device *hd=
ev, struct hid_driver *hdrv)
 		if (quirks ^ hdev->quirks)
 			hid_info(hdev, "HID-BPF toggled quirks on the device: %04x",
 				 quirks ^ hdev->quirks);
+	} else {
+		unsigned int quirks =3D hid_lookup_quirk(hdev);
+
+		/*
+		 * hdev->bpf_rsize became non-zero above, quirks set to 0, and we're
+		 * back with quirks =3D HID_QUIRK_INPUT_PER_APP.. which terrifies mice?
+		 */
+		if (quirks ^ hdev->quirks) {
+			hid_info(hdev, "HID-BPF toggled quirks on the device: %04x",
+				 quirks ^ hdev->quirks);
+			hdev->quirks =3D quirks;
+		}
 	}

 	if (!hid_check_device_match(hdev, hdrv, &id))


