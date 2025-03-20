Return-Path: <linux-kernel+bounces-569796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B029A6A7A1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB70A179248
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF6B222595;
	Thu, 20 Mar 2025 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="itTE3y7L"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B3D221F07;
	Thu, 20 Mar 2025 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478653; cv=pass; b=CGZ08CXFqam18xcJIgcew+hPc9P8JBRnhuMXEJVJuHUf/QCBlEeb3GLcqMIy9a+h+MrPmqlDMhr9lm6hqQCz4uXQymAulXYrcQfX/R9sd39NxHZ74znbrbieFx/WRcTWGzsk6iKp3vSCZnb4PymzgyU1ogMvFIB8CAPd4fRN7ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478653; c=relaxed/simple;
	bh=FJGkDF/tymf/u8VYaYBP7bBv4Mifo8RhklQ1Ki/gMF8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=A3DP38Oalq14NF7mDdZvOXqWoBF7OVQN8l4EpAhVZYhx2xokSXs2pqg1a6Bz4wZ6PM2j8S9m6LGwJyQ6tynx3tivnukx09/8vaYpJfQk50lg/A9VKmlJF3VcK226NKMX+zmw2WBVpMu3XziXrvGxhhqzE60rE64M48BRTJ3e/K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=itTE3y7L; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742478627; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Z31VeW3MhdJYyzmBGVjqYVr4ryGCz8+u2ghG7FDbdAYGgYRDFnQLNwrBHtX5Npq2j3HAaVCA3UdDb7NVwkcNpkxpE0nyg+Gy0+VtalwBLQNO7/R7aig1J+jT2G58lP9xFplgu3AcxnGnHZnRmuNeRhAgWXRLEKQaImj9vCxhJtU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742478627; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FJGkDF/tymf/u8VYaYBP7bBv4Mifo8RhklQ1Ki/gMF8=; 
	b=g6MNx7EzkABgdb06oZ6UorGTzQyp9CGvnajR6jJ8NXkp6upFcJIWsehoQNKaWoDm14nN0B+qzAD5II6L94NHsyl71QNKQ81p3kf9idWK5KEE9JTzhST4jwFze5pexrEdiCby37c9UX34rqJ/2wEtXV0E66fW8+9j88p4YB/qsDc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742478627;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=FJGkDF/tymf/u8VYaYBP7bBv4Mifo8RhklQ1Ki/gMF8=;
	b=itTE3y7L57sKJXFppS1xuuWOIulVMrCsci0gmiOwE5ZuLLm1lBEy2bbJjD6dAHlW
	Ry3jJmu+kzHL6IibARDDUdE0hoQB5X+4J8lc8oiga5QnBxOsKSa46ZWqrXsuaOvBzv7
	na0KpqrPcaiCwu70jkTj0Ps5x23bZ3mFa/nFAwjA=
Received: by mx.zohomail.com with SMTPS id 174247862340235.97143990973666;
	Thu, 20 Mar 2025 06:50:23 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v4] rust: kernel: add support for bits/genmask macros
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <D8KB8CPBOIY1.10ATK35TV2X79@nvidia.com>
Date: Thu, 20 Mar 2025 10:50:12 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 Fiona Behrens <me@kloenk.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BC968EEF-03CD-49A2-818D-08789791E461@collabora.com>
References: <20250318-topic-panthor-rs-genmask-v4-1-35004fca6ac5@collabora.com>
 <D8KB8CPBOIY1.10ATK35TV2X79@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-ZohoMailClient: External

Hi Alex,

> Would it make sense to also have u16 and u8 variants? I guess one can
> always use genmask_u32 and then cast to the desired type though.

There=E2=80=99s no u16 and u8 variants because I did not think there =
would be users.=20

I can add them otherwise, IMHO we should refrain from using casts when =
possible.

=E2=80=94 Daniel=

