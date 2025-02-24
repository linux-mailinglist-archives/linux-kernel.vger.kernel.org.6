Return-Path: <linux-kernel+bounces-529619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCB2A428F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243FB3B413D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C154264A9E;
	Mon, 24 Feb 2025 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="BxtokHy5"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033CF26159A;
	Mon, 24 Feb 2025 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416236; cv=pass; b=dJiM9ChyC9okSj7myiZzT6Q2+Qc+C1K7AGwYxLZ+maC7E8JtRT1gyIBP9wnu+RjKLoP3K8aWjTbyQUQyBBOhZVhS2OpatJoLChhUoQKvo3CNXVZR8oddfPshsw3+56qUBiFKwLG2B8WiFPrtRL8+NSLhAYhxiumSlKPNGaXlTjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416236; c=relaxed/simple;
	bh=Fob64pLhn756yjaoPrNGQR7uCYfjnodEB+ZsKpoZcXU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JY8TEsrX+INOEnBnJl706owDbYs6DrmU97Yfy2nM98MMKHm7RPJgkIuYZxoiBZNJ9kWlqNJ/AJO73vwyduxj2WEqr2Zluo0iBYNA+9TFOKUKG/0TZHFXPtAhQqNophsweZBs+PpmF+MJVglBFMU7iUejYkr/ZcpYbdOW1AyWgTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=BxtokHy5; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740416179; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DvI2yCqDHBN2rMIWC22aJWiMUTS+/9F5bs15FZudJRxJQQWzlSaWY7lZttMLjY417fYnl4ywZQ4uEFZBvkQ9gPL+IDSyuA9NPeqS1wG1KQlsO67F8vvVeqe0WRBPaSoY791xK/dNm/HuWxKB9DZV2QukbYPnshGU9HLurF+8Y8M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740416179; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3nu4ebyfHfzLRDpB6Q0n/OaNzHps1VPFty98l4YJd1Y=; 
	b=Ec2clG+dJfak9OJnzXnKhrY78CgVAIi2uGPJvxIhawLigCsZOdwF8TGXDkQu6Ze/2Ad/20Bds7ZfHJhWkR/Ti0lVfFVsj3CHGsP7xEwb5eUNwgmVKaSGhu1KC3A+yvK2fupzq9Vig2BV41seKIfqCB5IUhYOmtAYhjnnAXsDuUE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740416179;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=3nu4ebyfHfzLRDpB6Q0n/OaNzHps1VPFty98l4YJd1Y=;
	b=BxtokHy5zPWsJEFy989rH28CALuW7ihfjqmpspWD3liURD2FmBzBTCUOXLwVvbMB
	hC4ZiHznON+WgdKU2Mx7cIYh3SuIrsyQSWwF2zdP1SNO4enMXz8ySsUiiRNeyX9PS6T
	F5YPbb4k23nbwo3gxcekffR80DPoWRlOX6GPklgw=
Received: by mx.zohomail.com with SMTPS id 1740416177044884.7695181829265;
	Mon, 24 Feb 2025 08:56:17 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH v4 0/4] rust: configfs abstractions
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250224-configfs-v4-0-9af9b5e611f6@kernel.org>
Date: Mon, 24 Feb 2025 13:55:59 -0300
Cc: Danilo Krummrich <dakr@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Joel Becker <jlbec@evilplan.org>,
 Christoph Hellwig <hch@lst.de>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>,
 Fiona Behrens <me@kloenk.dev>,
 Charalampos Mitrodimas <charmitro@posteo.net>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E12F1175-63AB-47BE-88E7-B6DA627DA8E6@collabora.com>
References: <20250224-configfs-v4-0-9af9b5e611f6@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi Andreas, FYI:

Tested-by: Daniel Almeida <daniel.almeida@collabora.com>

i.e.:

```
sudo cat /mnt/rust_configfs/message=20
[  234.971000] rust_configfs: Show message
Hello World

sudo cat /mnt/rust_configfs/bar
[  335.542585] rust_configfs: Show bar

sudo sh -c "echo new_bar > /mnt/rust_configfs/bar"
[  382.114901] rust_configfs: Store bar

sudo cat /mnt/rust_configfs/bar
[  401.348487] rust_configfs: Show bar
new_bar

sudo mkdir /mnt/rust_configfs/child

sudo ls /mnt/rust_configfs/
bar      child/   message

sudo ls /mnt/rust_configfs/child/
baz

sudo cat /mnt/rust_configfs/child/baz=20
[  600.651618] rust_configfs: Show baz
Hello Baz

sudo mkdir /mnt/rust_configfs/child/grandchild

sudo ls /mnt/rust_configfs/child/grandchild/
gc

sudo cat /mnt/rust_configfs/child/grandchild/gc
[  670.093647] rust_configfs: Show baz
Hello GC
```

Is that last one (for the grandchild) really supposed to print =E2=80=9CSh=
ow baz=E2=80=9D ?

Please let me know if there=E2=80=99s anything else needed to test this =
fully. A review will soon follow.

=E2=80=94 Daniel=

