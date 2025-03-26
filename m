Return-Path: <linux-kernel+bounces-577628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DA0A71F94
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B21B16C1F5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224401F6664;
	Wed, 26 Mar 2025 19:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="jH439jNm"
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA3C9475;
	Wed, 26 Mar 2025 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743018619; cv=pass; b=D8Fh0V/dcey/JaZbMcB89X3YznmKRAD+7IvrJa8xOhKzeHiT6/UCQPB3Q9DMfvZnDZldqq6ZJuj0OjFaPsrGiJxUFWN4rsk+a9SGATKt2n1M7IqGstOg9T2xSzU755nkl05j7d8F6YSFnTPlYgFG7ZE/lT8d51C13OLr8Nt/zSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743018619; c=relaxed/simple;
	bh=DZjH0rnZ9KQepcFyfGU052IuDKdqdy6SNdZ7KN0z9F0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CXBiYuWpOFyI6Prazio+/s13zs3Mnovrx+qr/LjTbKj8xDK0BIVovMU+QiG+8PujulHm4HHChXs3451qFdAQ1ZIh9o3XW9cQxYFDh2F9Kd7wqS+/+r4xKGWCssreip9/y8eK0+Ocanti4nORuioxm1BnLWpxAu4jMJfKR1kln9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=jH439jNm; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1743018585; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Q9spLhNCKxguD9VttGffJojcVwi/6S2c1tLW4rS4hlQQ6JLJZF+KzpcuQbnt9vBH+PUaZZyI/+xTiYJVIGYOdxapRB2KuHNclyjAW5GlB3fTzQysgCXlYh6OJVZhCwyHUYQq82AebfmZBqlyRypNz8PHsqABmSM0/Tsc7rS9/uc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1743018585; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mxJOGuLS0MjjMJI0F/iG7CmGwB7XgMzMDMhBqNuWWHY=; 
	b=ebK1H+KW5iGv+nB44vvqvM2HJj+HSAC2lxdZd9cIysrn/nNmAV5sWGO2x2ae+VOpovGO2QF/k140hlKtz843nd8MiO9QDIk9vxsygfGOVgSFblGoq4ZFn8FoVmTkQA4tjdU5HxeKRD9+Bu1lTaBZKNkZiznOH3Uq0nW0tnAgPNU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1743018585;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=mxJOGuLS0MjjMJI0F/iG7CmGwB7XgMzMDMhBqNuWWHY=;
	b=jH439jNmyoxLuHKBfkyTQR1X/T40vJO/bA1pakU8y9vk8a1osBiAAHGFhMEznXiD
	oLlI6W51dGcjdmUG0NNZcgahcOspKL7usBZJY551k/Px9bw7KSakfDdlfMRSi1ZjJ6m
	g01tTS3wrHFZARoGzCnXrj8/wemkGN0ib68TQwFg=
Received: by mx.zohomail.com with SMTPS id 1743018582753218.35820885183966;
	Wed, 26 Mar 2025 12:49:42 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH RESEND v2] rust: regulator: add a bare minimum regulator
 abstraction
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <a98eb789-4c49-4607-ad15-76e260888d64@sirena.org.uk>
Date: Wed, 26 Mar 2025 16:49:26 -0300
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
 Boris Brezillon <boris.brezillon@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0698A75E-D43C-4D02-B734-BFE1B3CC5D34@collabora.com>
References: <20250326-topics-tyr-regulator-v2-1-780b0362f70d@collabora.com>
 <a98eb789-4c49-4607-ad15-76e260888d64@sirena.org.uk>
To: Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-ZohoMailClient: External



> On 26 Mar 2025, at 15:56, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Wed, Mar 26, 2025 at 03:39:33PM -0300, Daniel Almeida wrote:
>=20
> This is flagged as a resend but appears to be the first copy I've
> seen...

Hi Mark, you were not on cc earlier this morning, which is why this is =
being
resent. I left a comment about this, but apparently b4 did not pick it =
up.

>> Add a bare minimum regulator abstraction to be used by Rust drivers.
>> This abstraction adds a small subset of the regulator API, which is
>> thought to be sufficient for the drivers we have now.
>=20
>> +//! Regulators are modeled with two types: [`Regulator`] and
>> +//! [`EnabledRegulator`].
>=20
> It would be helpful to see what the client code actually looks like
> here.

Ack, I'll include examples in v3.

>=20
>> +    /// Enables the regulator.
>> +    pub fn enable(self) -> Result<EnabledRegulator> {
>> +        // SAFETY: Safe as per the type invariants of `Regulator`.
>> +        let res =3D to_result(unsafe { =
bindings::regulator_enable(self.inner.as_ptr()) });
>> +        res.map(|()| EnabledRegulator { inner: self })
>> +    }
>=20
> I assume this map does soemthing to report errors?

map() returns the error to the caller, if any. Notice that the return =
type is
Result<EnabledRegulator>.

>=20
>> +impl EnabledRegulator {
>=20
>> +    /// Disables the regulator.
>> +    pub fn disable(self) -> Result<Regulator> {
>> +        // Keep the count on `regulator_get()`.
>> +        let regulator =3D ManuallyDrop::new(self);
>> +
>> +        // SAFETY: Safe as per the type invariants of `Self`.
>> +        let res =3D to_result(unsafe { =
bindings::regulator_disable(regulator.as_ptr()) });
>> +
>> +        res.map(|()| Regulator {
>> +            inner: regulator.inner.inner,
>> +        })
>> +    }
>=20
> This looks like user code could manually call it which feels like =
asking
> for trouble?

Yes, user code can call this. My understanding is that drivers may want =
to
disable the regulator at runtime, possibly to save power when the device =
is
idle?

What trouble are you referring to?


>> +    /// Sets the voltage for the regulator.
>> +    pub fn set_voltage(&self, min_uv: Microvolt, max_uv: Microvolt) =
-> Result {
>> +        // SAFETY: Safe as per the type invariants of `Regulator`.
>> +        to_result(unsafe { =
bindings::regulator_set_voltage(self.as_ptr(), min_uv.0, max_uv.0) })
>> +    }
>=20
> set_voltage() is only implemented for enabled regulators.  It is
> reasonable for a driver to want to set the voltage for a regulator =
prior
> to enabling it in order to ensure that the device powers up cleanly,
> there may be different requirements for power on from on and idle so =
the
> constraints may not be enough to ensure that a device can power on
> cleanly.
>=20
>> +    /// Gets the current voltage of the regulator.
>> +    pub fn get_voltage(&self) -> Result<Microvolt> {
>> +        // SAFETY: Safe as per the type invariants of `Regulator`.
>> +        let voltage =3D unsafe { =
bindings::regulator_get_voltage(self.as_ptr()) };
>> +        if voltage < 0 {
>> +            Err(Error::from_errno(voltage))
>> +        } else {
>> +            Ok(Microvolt(voltage))
>> +        }
>> +    }
>=20
> Same issue here.

Ok, we can move the implementation to Regulator then.

=E2=80=94 Daniel


