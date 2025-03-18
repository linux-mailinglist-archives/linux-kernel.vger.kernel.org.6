Return-Path: <linux-kernel+bounces-566735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A183DA67BDC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04FF1176333
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9549D212B11;
	Tue, 18 Mar 2025 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="EKDHu0/r"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2E21917FB;
	Tue, 18 Mar 2025 18:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322204; cv=pass; b=q1KCqNwig4J4BpYjyn2JfzT9cEb3qmqpSz4qBzcb1MHzs0B+AT4/YihI8AOH2TSAJ/d9uHJH4GBBux6vQDq7R85QYULVnVhDfV5ZRRTdHaEfxPeV3ndC09Vt5WrQCZXm4h2QoaWAbjHHfIt/tF2UNpKuRh9dGU38aG1VFPsbMVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322204; c=relaxed/simple;
	bh=JQor4MlEvVYK8iLvFu1ZaYzbdCr52smhN74Cto7jXhA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UAH0tmRLafx5wcDZwqoaVoZNs6BDXRoO5Dwilyi0gWod3Fm/odgqrsWH0tBS/XuiQlD/llw25l41qjvuMtLztlv1RKvT+7mtJs6MkzcUQSVA+Zb6wQMMlwZC81ds/SVHLU0TdPnt8pclQmOhQvROhcSgRmN2OwGR+ZTinBqdhNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=EKDHu0/r; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742322175; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=b2rs+cCaYXPdMyS8VcK3Q8hcOXWUpuBB5aoM1UvtA03WtKyzp1TXN6RT4EUnnO6l+ON01OdePPf6/u9OSPoi9HxPnUyrMiGjg9g6SVJf3A5tPEncI7NxYrdiLfaipCqQBYHcc2iyuWAvwBesDiXXsu5+OrPo2wfRK/LOtW0r4+8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742322175; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MjgEMTLTXR3ykUAZxJQ5ZFEgeZV2qtBNQAlh289P238=; 
	b=cbtAUoeD0FUdKt0oYr2Y1Bu3NDYMknVgqBMfqJFzAIirqLuV8wWcCqKnHus33DPNHgGjdTY6z9hUy8NzvlesebUHk0DOweOnP98jE5J4NAh6scE3Zxw4FvWq3RrlG1yB6Q5jvUR1H+e7xdjUgv8JL5O5wlI6Vqa2xgT5jBEY5Is=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742322175;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=MjgEMTLTXR3ykUAZxJQ5ZFEgeZV2qtBNQAlh289P238=;
	b=EKDHu0/rzE1PheRxod9pkGQaYQx1wR1GmfC3BdYXrwDGgmGa8Cd4VpP4FpuZOeUy
	BJscnG3szHxExRIQKyxkoXzfY87cHIi+uWUG0RQaN5NxnKcHXu/nJk2MNgDVZfnNi2/
	9FrIRe6MOQ76JQK6bl32FgQDQf0T7x/KaBDif5TE=
Received: by mx.zohomail.com with SMTPS id 1742322173580262.17469035229453;
	Tue, 18 Mar 2025 11:22:53 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v7 3/3] rust: platform: allow ioremap of platform
 resources
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <Z9mwu-RHwZ8qwcbH@cassiopeiae>
Date: Tue, 18 Mar 2025 15:22:37 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FF128DEF-28D6-4302-9C53-2DD4D417053A@collabora.com>
References: <20250318-topics-tyr-platform_iomem-v7-0-7438691d9ef7@collabora.com>
 <20250318-topics-tyr-platform_iomem-v7-3-7438691d9ef7@collabora.com>
 <Z9mwu-RHwZ8qwcbH@cassiopeiae>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-ZohoMailClient: External

Hi Danilo,

> On 18 Mar 2025, at 14:43, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> Hi Daniel,
>=20
> On Tue, Mar 18, 2025 at 02:20:43PM -0300, Daniel Almeida wrote:
>> The preceding patches added support for resources, and for a general
>> IoMem abstraction, but thus far there is no way to access said IoMem
>> from drivers, as its creation is unsafe and depends on a resource =
that
>> must be acquired from some device first.
>>=20
>> Now, allow the ioremap of platform resources themselves, thereby =
making
>> the IoMem available to platform drivers.
>>=20
>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>> ---
>> rust/kernel/platform.rs | 123 =
+++++++++++++++++++++++++++++++++++++++++++++++-
>> 1 file changed, 122 insertions(+), 1 deletion(-)
>=20
> You need to rebase this onto driver-core-next.

Right, I totally forgot about this.

>=20
>>=20
>> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
>> index =
1297f5292ba9b7ca9784f84979efbeccb0768bd3..56f3d7c0d536d77082d7f8d2407de17e=
e3e95ffa 100644
>> --- a/rust/kernel/platform.rs
>> +++ b/rust/kernel/platform.rs
>> @@ -5,8 +5,14 @@
>> //! C header: =
[`include/linux/platform_device.h`](srctree/include/linux/platform_device.=
h)
>>=20
>> use crate::{
>> -    bindings, container_of, device, driver,
>> +    bindings, container_of, device,
>> +    devres::Devres,
>> +    driver,
>>     error::{to_result, Result},
>> +    io::{
>> +        mem::{ExclusiveIoMem, IoMem},
>> +        resource::Resource,
>> +    },
>>     of,
>>     prelude::*,
>>     str::CStr,
>> @@ -191,6 +197,121 @@ fn as_raw(&self) -> *mut =
bindings::platform_device {
>>         // embedded in `struct platform_device`.
>>         unsafe { container_of!(self.0.as_raw(), =
bindings::platform_device, dev) }.cast_mut()
>>     }
>> +
>> +    /// Maps a platform resource through ioremap() where the size is =
known at
>> +    /// compile time.
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```no_run
>> +    /// use kernel::{bindings, c_str, platform};
>> +    ///
>> +    /// fn probe(pdev: &mut platform::Device, /* ... */) -> =
Result<()> {
>> +    ///     let offset =3D 0; // Some offset.
>> +    ///
>> +    ///     // If the size is known at compile time, use =
`ioremap_resource_sized`.
>> +    ///     // No runtime checks will apply when reading and =
writing.
>> +    ///     let resource =3D pdev.resource(0).ok_or(ENODEV)?;
>> +    ///     let iomem =3D =
pdev.ioremap_resource_sized::<42>(&resource)?;
>> +    ///
>> +    ///     // Read and write a 32-bit value at `offset`. Calling =
`try_access()` on
>> +    ///     // the `Devres` makes sure that the resource is still =
valid.
>> +    ///     let data =3D =
iomem.try_access().ok_or(ENODEV)?.readl(offset);
>> +    ///
>> +    ///     iomem.try_access().ok_or(ENODEV)?.writel(data, offset);
>=20
> I'd probably write this as
>=20
> || -> Result {
> let iomem =3D iomem.try_access().ok_or(ENODEV)?;
>=20
> iomem.read32(offset);
> iomem.write32(data, offset);
>=20
> Ok(())
> }()?;
>=20
> There's also a patch [1] in progress that makes this more convenient.
>=20
> [1] =
https://lore.kernel.org/rust-for-linux/20250313-try_with-v1-1-adcae7ed98a9=
@nvidia.com/

Thanks!

=E2=80=94 Daniel



