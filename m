Return-Path: <linux-kernel+bounces-380176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90EC9AE9CD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703921F21061
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375C01E5735;
	Thu, 24 Oct 2024 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="S3e/wCQi"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83011547C6;
	Thu, 24 Oct 2024 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782443; cv=pass; b=ErcJ+bXVRnR30Og+aPvhCRyzWJfoyTnvbKiBQKOIWnOkMG9Ah7udRJRLREXj3vbnCd7u5VthqT1Nnn47rRBPXoOgBvnDRdpbueHqINMz75duZ/Vi9cw9N4Kb2zQtoQdK3G3eLvJ0Gx/00DUFsNsAltMe40lxmCFTOtERJ9RcgIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782443; c=relaxed/simple;
	bh=Wz/PVw0CPKAqygkaCBh8BmQFt0VNmRCIKbV4klh5YsE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=oI8cuktdNds7oJVAgLMlUdoeAWgl+lD/MOYwQeXfmAEEx4p4CXxa1amb8qCz4L3BAcOh4Dxc5xa8FO19fW1Tehxx8yeceH8Xnz1hy8r/oaAYa7odyXx95GPgkiGt18ybAgPfJH4Mz7HSgk+IYEatlldEW9aHIPyfrHlUDQ6yrHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=S3e/wCQi; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1729782423; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CfETI2KyJQZd8pl7i6h0p6q028h4BCiYPwThbOG1VJ61YTaVFQejrjxoGRRgb8m/s9Pc/BaADjC+KVMgbKceM9kg2KEIExiuiaXKxWS6rX6ua0uI/A+QDVLY3imyI08J7SGiXMDbtya/htM5R4TdUgw77zJncuAbDtC/gHqOSWo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729782423; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0qQwptEb7Ebb/SwUTLcOOwAte79lhU9t6XG2RmJvzg4=; 
	b=ZHoZwvv8MrQTmpNfKXfPLnOXkvaUEtnbq7Us7mrRchiK4eXZa00pcZa/ie/miDA+rsCJM1KFPHx/XtsSzJNLfvccdS2J/e7C2gX04ferM+kRtQrozesA8WbDjXF9D9QzQl7q5KPCsa35AtLr3pBCosgwvU+L/2AjirxGtN9eEus=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729782423;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=0qQwptEb7Ebb/SwUTLcOOwAte79lhU9t6XG2RmJvzg4=;
	b=S3e/wCQitiARBJrbildi0RHQEyNYwjzDfxdcS3pzigPKCQQeSrtumaHjWH3N11Qc
	PmbwqWGZqyJwlvoqeZ/Yn9GkMg7hznjZDPuAPSk6+WmT3Ifs2cNpKHag578YG9T+JaX
	mK8D2ptoW11VbJrwDqxyLgK1ExQ0Uhs6qA064aZ8=
Received: by mx.zohomail.com with SMTPS id 1729782422250823.0422495875763;
	Thu, 24 Oct 2024 08:07:02 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH v2] rust: kernel: add support for bits/genmask macros
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20241024-topic-panthor-rs-genmask-v2-1-85237c1f0cea@collabora.com>
Date: Thu, 24 Oct 2024 12:06:47 -0300
Cc: linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9A3613EA-3901-4C44-A3C3-7A6B7DB49CDB@collabora.com>
References: <20241024-topic-panthor-rs-genmask-v2-1-85237c1f0cea@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-ZohoMailClient: External

Sorry, I switched to b4 yesterday and I am still getting used to the =
workflow with it.


> On 24 Oct 2024, at 11:17, Daniel Almeida =
<daniel.almeida@collabora.com> wrote:
>=20
> These macros are converted from their kernel equivalent.
>=20
> ---
> - Added ticks around `BIT`, and `h >=3Dl` (Thanks, Benno).
> - Decided to keep the arguments as `expr`, as I see no issues with =
that
> - Added a proper example, with an assert_eq!() (Thanks, Benno)
> - Fixed the condition h <=3D l, which should be h >=3D l.
> - Checked that the assert for the condition above is described in the
>  docs.
>=20
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>


This should read =E2=80=9CChanges from v1=E2=80=9D


