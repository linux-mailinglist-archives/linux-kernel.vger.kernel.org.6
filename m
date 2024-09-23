Return-Path: <linux-kernel+bounces-335838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A3097EB5C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15091F21F73
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DBE198826;
	Mon, 23 Sep 2024 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b="GpkcaGWl"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A567F8002A
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 12:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093396; cv=none; b=Z5w+csMmFfWLDWdGG11aXZmbi4ZPOE04E1p2e/ZQmXybLV8DhaDm6M3DL7BD76QZtWc5qiI/7tVCbYpmzF/HrXzN48h/kd9sA3tQjb800QmKCU4aBUJSH1moeyKS+YOqh6e1KOzmMXreto3u++6r3YtaGuFjCvbGNymlSBTzc3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093396; c=relaxed/simple;
	bh=Ufv/Nhv+LwbWnDfKtNThvrjt5Ags8GFJ5qk0h+5FfB0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=RngS+mW9Yoo0nlgQiu7QJZ7VrLCJ20oWHfPD2CY1PVGYEEqYiKUJB4AXcpAF5sCSovCM4kBn0RCN6rHV7kEzXkVBCxVlldvcPfl+ae0VYvh4f4ycftxTJe9+wuo9TRUs+GKLuYqQmWxVzJoHHKM37Q2g1aFh3kxfyYmq4usTH6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=GpkcaGWl; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1n.io
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1727093391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixnMkAOJnswMRKlcax1/CWVcRrlmqkRdAgyF2JlyCck=;
	b=GpkcaGWlmuLk/fAAO5o7NIQ1/8UtG/HmgImkOX5oaCrblVmIVdBrbLYBIlrmlnhzH2zk3K
	2x99IraBsSebaP6HDYa09aUD1RUUUZvcZh0wGKjuUoSnERjpxWi6TcWir18gNCLZrBB5mX
	Q/5uF+lYxvi5Q3wWe3W04TCwBNF/6Qpbas6S8ofrKxF7y34P1d02lTY5Ivp0xuZfn8SbYm
	vZip/fmXXYuG7r7J4iMxEwol7nxahyiUuOWrJlo6jvOZm7XAHaoSfuNApNIaOCkTH8dyLv
	OP4QB8piThcY4tbZFjrno00d7K3tBEQcmT1IoewWusDxT2qImSwdyZZoQnJgXQ==
Content-Type: multipart/signed;
 boundary=1fe467fbc4cdced47aea578ab9eaa1a2913fd6844acbb8ab283deb75ca30;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 23 Sep 2024 12:09:42 +0000
Message-Id: <D4DNIARBI7Q0.13E9XY3QTDIW3@b1n.io>
Subject: Re: [PATCH 2/7] staging: vt6655: Rename variable iTDUsed
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Xingquan Liu" <b1n@b1n.io>
To: "Philipp Hortmann" <philipp.g.hortmann@gmail.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <linux-staging@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
References: <20240920162025.31465-1-b1n@b1n.io>
 <20240920162025.31465-2-b1n@b1n.io>
 <e7bfce0c-74a4-4c0a-9930-a3fe9d5ea5fb@gmail.com>
In-Reply-To: <e7bfce0c-74a4-4c0a-9930-a3fe9d5ea5fb@gmail.com>
X-Migadu-Flow: FLOW_OUT

--1fe467fbc4cdced47aea578ab9eaa1a2913fd6844acbb8ab283deb75ca30
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed

Hi,

I'm a bit confused. Should I rename struct vnt_tx_desc *apCurrTD[TYPE_MAXTD];
to curr_td? 

It looks like 'ap' means array pointer.

For struct vnt_rx_desc *aRD0Ring;, where 'a' doesn't means array, should
I rename it to rd0_ring?

-- 
Xingquan Liu


--1fe467fbc4cdced47aea578ab9eaa1a2913fd6844acbb8ab283deb75ca30
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iM4EABYKAHYWIQRK8k7aQ0rr/Uwki+E2I1LDHPWnXgUCZvFajlgYaHR0cHM6Ly9r
ZXlzLm9wZW5wZ3Aub3JnL3Zrcy92MS9ieS1maW5nZXJwcmludC8zMEFGMUFDMDcz
MDg5M0VEQzE0OUI3OTVCMDA3OUIxMkU2Qzk4RUE2AAoJEDYjUsMc9adetcMBAMM+
ZPxq4MmFWLV+gDsy8jcU18j6UukKo22G6WAVFTopAQDI82P08QRvesIEaWU0mz41
bL9udtKeCtiqZIdYSRBxBg==
=57QM
-----END PGP SIGNATURE-----

--1fe467fbc4cdced47aea578ab9eaa1a2913fd6844acbb8ab283deb75ca30--

