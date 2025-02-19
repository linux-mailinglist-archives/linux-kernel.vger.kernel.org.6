Return-Path: <linux-kernel+bounces-522712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D23F7A3CDB4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9562E172FF0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D925025D539;
	Wed, 19 Feb 2025 23:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Tzgych9A"
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3181B87EB;
	Wed, 19 Feb 2025 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740008191; cv=pass; b=NVb7lVGGy5tmeXyYSR+8j4piaZi8RIcKPkyZKRF0K3IVRtEDAkonPcfk9aDzymTl5GEhH/5WgXTox5p0GKmrtvsvcpNlCDoqHPseZj1x/tQudQW9FpgnroC45ZmMuHr010Ua0aphfLmP3C7qTfojAPlrDLGMq9SswtFsn54S0F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740008191; c=relaxed/simple;
	bh=B3sy8Cxh+EnoriTU5vxUqf51qpiP6eFOoFGMd2MlSH8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LSEmldJxhaMzZcoGAkQSineUjIwhaUUMEgNaP+4uFA2mcBs6VuL1a07urZVELDUefOTNkoNyr3xhV7WenQBkz+UbGo7a2p93KA5j5fzpWp6oRJl/7Se0ZwMAviJxAGMoWedXbrHFyOftH63I6nFxFlbyf3JDOJbZgMmahCr2u2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Tzgych9A; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740008166; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iT4+XJqeX04IKZDtcnWuTImiCqcpvDYac8myU3zaC73Sx9D/0XW69CQ0fvd6ycrii8COpqlZweV6MGhFuzSbp1FjiZyawaHdQ8Zht1q9HH1VEETwN7KRSH3Nux2dEsmKbm/Q8bydPlS6jJb/xS14yyPURzSTw05tbejrBIShWSk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740008166; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=z9zBRcRrIN+gbKJfa3s2WwYoCc1xTTd7FgPo3CUQyCQ=; 
	b=ec0lWeqKjAPzfS/M7YyrbQInX6MBBUNdc5tOoypLcJC6dyQLI6Lctka3CB5FO2g65PWa9O5mOJlIEYJ+bNYvaSTLN9p2xga0gHi1mDISCsFDjfOD52VoPjf3dNo1MU6tRSgg6+lVMTbMcrvE28AkZngDUZFlmlUzHTFFR7xmCSw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740008166;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=z9zBRcRrIN+gbKJfa3s2WwYoCc1xTTd7FgPo3CUQyCQ=;
	b=Tzgych9AeYNHVVI4e4VFC6ciCV4gnIcKkV+pHtTaK/Joo1GMYluwYqfwHC+lwGwa
	c8DU8KTfAfW3SW5kEfoji1l/tvU3Mg4ug9B/CtTD5ATbse3JOPJ6O1w0MKS1SSYw2er
	MP1M3CBKKH55BWPhlh/1OzXlSoHhXl5Fh0/v5TR4=
Received: by mx.zohomail.com with SMTPS id 1740008164074315.64003209659415;
	Wed, 19 Feb 2025 15:36:04 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH] rust: regulator: add a bare minimum regulator abstraction
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <Z7ZjzJ2Rfrt8j0s1@finisterre.sirena.org.uk>
Date: Wed, 19 Feb 2025 20:35:47 -0300
Cc: lgirdwood@gmail.com,
 sebastian.reichel@collabora.com,
 sjoerd.simons@collabora.co.uk,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 a.hindborg@kernel.org,
 benno.lossin@proton.me,
 aliceryhl@google.com,
 tmgross@umich.edu,
 dakr@kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5E354BB7-9CD5-4615-8EAF-98B9F498713A@collabora.com>
References: <20250219162517.278362-1-daniel.almeida@collabora.com>
 <Z7ZjzJ2Rfrt8j0s1@finisterre.sirena.org.uk>
To: Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi Mark,

> On 19 Feb 2025, at 20:05, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Wed, Feb 19, 2025 at 01:25:16PM -0300, Daniel Almeida wrote:
>=20
>> Add a bare minimum regulator abstraction to be used by Rust drivers.
>> This abstraction adds a small subset of the regulator API, which is
>> thought to be sufficient for the drivers we have now.
>=20
> ...
>=20
>> Note that each instance of [`Regulator`] obtained from
>> `Regulator::get()` can only be enabled once. This ensures that the =
calls
>> to enable and disable are perfectly balanced before `regulator_put()` =
is
>> called, as mandated by the C API.
>=20
> This sounds very wrong, a major use case for consumers is to enable =
and
> disable regulators at runtime.  I would expect that the Rust code =
might
> want to have it's own reference counting (and probably should), but =
not
> being able to disable a regulator after enabling it seems to be a =
great
> big red flag.
>=20
>> +    /// Enable the regulator.
>> +    pub fn enable(&mut self) -> Result {
>> +        if self.enabled {
>> +            return Ok(());
>> +        }
>=20
> This isn't what the changelog claimed, it's silently ignoring =
duplicate
> attempts to enable and...
>=20
>> +        // SAFETY: Safe as per the type invariants of `Regulator`.
>> +        let res =3D to_result(unsafe { =
bindings::regulator_disable(self.inner.as_ptr()) });
>> +        if res.is_ok() {
>> +            self.enabled =3D false;
>> +        }
>=20
> ...we actually support disabling and reenabling multiple times, it's
> just that there's a maximum of one enable at once from the consumer =
and
> we silently ignore duplicated enables and disables.  That's better but
> it's asking for trouble.

Maybe there was a language issue on my end here.

When I say once, I mean exactly what the source code shows, i.e.: it can =
be
enabled once, and further calls will be ignored. If it is disabled, it =
can then be
enabled once, with all further calls ignored, etc.

What I wanted to say is that this abstraction does not support exactly =
what you
suggested, i.e.: a refcount of how many times it was enabled.

I agree that this is not what the word =E2=80=9Conce=E2=80=9D means. =
Sorry for the confusion.

>=20
> If you're going to support both enable and disable (and all things
> considered you probably should TBH) it would be better to just =
reference
> count the enables like the C code does and then complain about it if
> someone tries to free the regulator object without underwinding their
> enables, or just possibly just clean them up.  Silently ignoring
> duplicate enables or overflowing disables doesn't seem like it plays
> well with the safety goals that Rust has, it's asking for bugs - a big
> part of the reason the C API does things the way it does is that it =
will
> notice if the enables and disables aren't joined up.  You can easily
> wind up with one part of the code disabling the regulator underneath
> another part that's still trying to use the hardware and things tend =
not
> to go well when that happens.

I thought about that, something like:

```
  fn drop(&mut self) {

   // someone probably forgot to call disable?
    while self.enabled_count > 0 {

            // Try to disable, this will decrement self.enabled_count
            if let Err(e) =3D self.disable() {

              // But don=E2=80=99t loop forever if it fails
              break;
            }
        }
  }
```

I asked for a few opinions privately and was told that =E2=80=9Cif the C =
API prefers not to do that
why should you?=E2=80=9D

>=20
> Perhaps an enable should be an object that's allocated and carried =
about
> by whatever's holding the reference, I don't know if that plays nicely
> with how Rust likes to ensure safety with this stuff?

As I said, this doesn=E2=80=99t work very well, unless someone corrects =
my reasoning on a
previous email. Having a single type =E2=80=9CRegulator=E2=80=9D is =
probably much saner than =E2=80=9CRegulator=E2=80=9D
and =E2=80=9CEnabledRegulator=E2=80=9D.

Your =E2=80=9Crefcount=E2=80=9D idea works just fine, though. I=E2=80=99ll=
 send a v2.

=E2=80=94 Daniel=

