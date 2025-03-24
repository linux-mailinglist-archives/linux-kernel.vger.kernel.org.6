Return-Path: <linux-kernel+bounces-574300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F00A6E371
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15E53AAFF0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2097D199948;
	Mon, 24 Mar 2025 19:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="TPl1nyZU"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42992E3381;
	Mon, 24 Mar 2025 19:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844354; cv=pass; b=d5h/jI6YxZMV0nlV14udVnfPcMZoRjAetungbKbiqv4m8pJ4S5F3mjdPdqnkCXLZfZubwpq1S7LzZCRF7QbS/9Y9onBN7R1vSlejyA1U4lNeRyfRa3hOp9blVnn8zsYXGJh9HnDIbeHmgVA2v77Sxp5KrrA6sLIvoANstq/TRu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844354; c=relaxed/simple;
	bh=+kFk9rhdiDAm/oCDyLKl9B/OAxtodeYjS1Mr/hB+Q/4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TmOETr2oq+mwPY8XGrHTspZHxRMZ6CFBh4gPxKtWjQh4e2YGKl7oL6kiVPIEIu8qE11HrKPUnH6wDNZxf9xrqifJhrrN5Dlb+zjxKjYf0RN6+BLHnHYolKVtcdVzcrIoMUaVGb5vkQlt5c1I/yD3fO33aTEWr5Sbf7Xn8gPyd5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=TPl1nyZU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742844327; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Swya0szKRZ74K4uMDR5Q2HYkhrNTsV98nQASLIUdYSTu0pX1TV0ufTqnyUXOt0MDBjoAxvZnQhMHjH295lK7G1/YMt9AJp3kpK6uBOb+pzUB7ww2xNCGkIDpRmmlvK9RlmXZyzbI9CUL9x13mAdQWKfj8nBu/okltIxW2hj9bTI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742844327; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=k8Y7CFUOAycS3oTxDxslZk149LNwr8JZUVw30eo4R5Y=; 
	b=lsL0Xg7e8xAwEY5wdiYLM3H9Refz4PUSVk/9M7q+udDrxI/XIpXxDaT1843eVvGuJUCas9U6EaB0N+iP1Llavs8lpTZwMt7ziSTEa9GQhINekKXO7EJdJsZijKpeRXTos79kOENjSbJLVroQEpJEJG0ga6pbXWpbUDvN+Fckz1c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742844327;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=k8Y7CFUOAycS3oTxDxslZk149LNwr8JZUVw30eo4R5Y=;
	b=TPl1nyZUbi2yI//ivducmbo9Tst2FtnT0BPYqZbm2M8BZZO/mOxK4JdGZIWxbyUh
	fTPnkm0YRH+q9aoRBvSiEbNoqXoSWdH2xoYe4ol+/GxlFGlsQKTvgju/qSKw/Nq2A7p
	4FQcdhsx8x88ulnveQ7pAbX4FUBamkeVksTLeca4=
Received: by mx.zohomail.com with SMTPS id 1742844324407222.7563228461404;
	Mon, 24 Mar 2025 12:25:24 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH 2/2] rust: drm: Add GPUVM abstraction
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CANiq72mQ3zuYmsq1PD-49kKLNji8OJwuvxK5QWkNaBMuC-PHQg@mail.gmail.com>
Date: Mon, 24 Mar 2025 16:25:07 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Asahi Lina <lina@asahilina.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <509EADD7-607B-4DED-ADAC-152D7338EB50@collabora.com>
References: <20250324-gpuvm-v1-0-7f8213eebb56@collabora.com>
 <20250324-gpuvm-v1-2-7f8213eebb56@collabora.com>
 <CANiq72mQ3zuYmsq1PD-49kKLNji8OJwuvxK5QWkNaBMuC-PHQg@mail.gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-ZohoMailClient: External

Hi Miguel, thanks for having a look at this:

> On 24 Mar 2025, at 14:36, Miguel Ojeda =
<miguel.ojeda.sandonis@gmail.com> wrote:
>=20
> Hi Daniel,
>=20
> A few quick notes for future versions on style/docs to try to keep
> things consistent upstream -- not an actual review.
>=20
> On Mon, Mar 24, 2025 at 4:14=E2=80=AFPM Daniel Almeida
> <daniel.almeida@collabora.com> wrote:
>>=20
>> +#[allow(type_alias_bounds)]
>=20
> The documentation says this is highly discouraged -- it may be good to
> mention why it is OK in this instance in a comment or similar.

Someone correct me here, but I see no issue with this warning. That=E2=80=99=
s
because we need the bound to make `<T::Driver as drv::Driver>` work in =
the
first place. Otherwise, we=E2=80=99d get a compiler error saying that =
there=E2=80=99s
no `Driver` associated type (assuming the case where a random T gets
passed in)

So, for this to be a problem, we would need to mix this up with =
something that
also has a `Driver` associated type, and this associated type would also =
need a
drv::Driver bound.

In other words, we would need a lot of things to align for this to =
actually
have a chance of being misused. When you consider that this is then only =
used
in a few places, the balance tips heavily in favor of the convenience of =
having
the type alias IMHO.

In fact, the docs point to the exact thing I am trying to do, i.e.:

>  these bounds may have secondary effects such as enabling the use of =
=E2=80=9Cshorthand=E2=80=9D associated type paths

>  I.e., paths of the form T::Assoc where T is a type parameter bounded =
by trait Trait which defines an associated type called Assoc as opposed =
to a fully qualified path of the form <T as Trait>::Assoc.=20

>=20
> Also, could this be `expect`? (e.g. if it triggers in all compiler
> versions we support)
>=20
>> +// A convenience type for the driver's GEM object.
>=20
> Should this be a `///` comment, i.e. docs?
>=20
>> +/// Trait that must be implemented by DRM drivers to represent a DRM =
GpuVm (a GPU address space).
>=20
> (Throughout the file) Markdown in documentation, e.g. `GpuVm`.

By the way, maybe we should have a lint for CamelCase in docs? I tried =
my best to
cover all of these, but some slip through :/

i.e.: if you write something in CamelCase somewhere in the docs, there's =
a high
chance that you should actually use Markdown and link as appropriate.

I have no idea whether this would actually work in practice, to be =
honest. It=E2=80=99s just
a random suggestion (that I'd be willing to help with).


>=20
> (Throughout the file) Intra-doc links where they work, e.g. [`GpuVm`]
> (assuming it works this one).
>=20
>> +        // - Ok(()) is always returned.
>=20
> (Throughout the file) Markdown in normal comments too.
>=20
>> +/// A transparent wrapper over `drm_gpuva_op_map`.
>=20
> (Throughout the file) A link to C definitions is always nice if there
> is a good one, e.g.
>=20
>    [`drm_gpuva_op_map`]:
> https://docs.kernel.org/gpu/drm-mm.html#c.drm_gpuva_op_map
>=20
> Ideally we will eventually have a better way to link these
> automatically, but for the time being, this helps (and later we can do
> a replace easier).
>=20
>> +/// `None`.
>> +
>> +/// Note: the reason for a dedicated remap operation, rather than =
arbitrary
>=20
> Missing `///` (?).
>=20
>> +#[repr(C)]
>> +#[pin_data]
>> +/// A GPU VA range.
>> +///
>> +/// Drivers can use `inner` to store additional data.
>=20
> (Throughout the file) We typically place attributes go below the
> documentation -- or is there a reason to do it like this?

I will be honest with you here: I never remember the right order for =
docs and attributes.

I=E2=80=99ll fix this.

>=20
> We had cases with e.g. Clippy bugs regarding safety comments that
> could be workarounded with "attribute movement", but it does not seem
> to be the case here.
>=20
>> +        if p.is_null() {
>> +            Err(ENOMEM)
>=20
> For error cases, we typically try to do early returns instead.
>=20
>> +    /// Iterates the given range of the GPU VA space. It utilizes
>> +    /// [`DriverGpuVm`] to call back into the driver providing the =
split and
>> +    /// merge steps.
>=20
> This title (and the next one) may be a bit too long (or not -- please
> check in the rendered docs), i.e. the first paragraph is the "title",
> which is used differently in the rendered docs. If there is a way to
> have a shorter title that still differentiates between the two
> methods, that would be nice.
>=20
>> +    /// # Arguments
>> +    ///
>> +    /// - `ctx`: A driver-specific context.
>> +    /// - `req_obj`: The GEM object to map.
>> +    /// - `req_addr`: The start address of the new mapping.
>> +    /// - `req_range`: The range of the mapping.
>> +    /// - `req_offset`: The offset into the GEM object.
>=20
> Normally we try to avoid this kind of sections and instead reference
> the arguments from the text (e.g. "...the range of the mapping
> (`req_range`)...") -- but if there is no good way to do it, then it is
> OK.

Ack.

>=20
>> +// SAFETY: All our trait methods take locks
>=20
> (Throughout the file) Period at the end.
>=20
> Thanks!
>=20
> Cheers,
> Miguel

=E2=80=94 Daniel=

