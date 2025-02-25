Return-Path: <linux-kernel+bounces-530894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0D7A439E9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C8F17CC89
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2BB264A62;
	Tue, 25 Feb 2025 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="kfBhauOp"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54D2770B;
	Tue, 25 Feb 2025 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476318; cv=pass; b=cI1B/Bf4IJYXL+09cYlUQTEGoIjHyb69kCLF2Sn4xo/b8IjRcWpCNCeCR5udagUENzeUPeCFVGNqq4wnRCWw6GESacXMx9fnACJK0H/we4KMzV7SDtKsgnBOnkcF/u/o1fFfzmtp955r0TiyaiHqZ/nsGtxhEWYiQrPyOOi0I2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476318; c=relaxed/simple;
	bh=WepjCdKpfsDunMZVmF4JsfqfzSNxfOKfCAManVRjDIE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=H+R/d2w3wgITZB3QvLqZMZ4MnezEYT2q0Wjxo0k/hgVHrUytD/3wkDBrxogKd3F7LchN770MdYdn+4AzLYxC9nca7Ez62fNhCTWAJ+EPmO4cADYp3BwHXbYxCx8dTAbTTfc2DcVtWZQKnD45uArf/74Z8Rv6q5eTTAhVV2D9YpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=kfBhauOp; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740476275; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iaTLHNWzZANWkSHvQcnjLdTiITwmdvrVbtSt5VyOreKwgtOBOEZwnyiqL+yBSNJxRD7WU6/p0nC88LBMtQP4WeFgHQgWR45lreSsc+jkUrTus3cp0qnLiIKq2JJyLc8QwYEEYXC7dX1xRRuQB00p3b3P1kiNUC98hcFJqPpruPg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740476275; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mbIJtXwXjtJlIQdygGWRyuQlQVKs6xykb4NhbVC0jk0=; 
	b=PAkZYUXivVj1LZkFibsPdym0/v4lm/bmG0WQFIl71w+JQMewJ+pymYDhAdlz5Awbz0dt8fGKe7BXKVDRjsROvD8ty2MZkTzWiKOtqnU3sUxUvo1ZrJ32l8Iq7TkMuUb1o9a7P4Nj1njNU1gU97Umh6tfmcuqCayEqaZg1L8JRhg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740476275;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=mbIJtXwXjtJlIQdygGWRyuQlQVKs6xykb4NhbVC0jk0=;
	b=kfBhauOpyXn5U3+2bHhvOFmpCeKRSeksX8Sr/JDXvYSeqKuCcHOvnWcicNlsfcOG
	pWutrWUidti8m3p+hwBUM2QoYSpqr+7uV1mbZOyEiHSmt3NEhks1MJlSM290VsxF1MH
	NKqb5HQfPVoq496TRo+jcZamq40WPJBwSGQ2Lmig=
Received: by mx.zohomail.com with SMTPS id 1740476271960416.2806493078207;
	Tue, 25 Feb 2025 01:37:51 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH v4 3/4] rust: configfs: add a sample demonstrating
 configfs usage
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250224-configfs-v4-3-9af9b5e611f6@kernel.org>
Date: Tue, 25 Feb 2025 06:37:33 -0300
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
Message-Id: <CB975A56-A8D5-4615-8755-04D7B0BBBCA5@collabora.com>
References: <20250224-configfs-v4-0-9af9b5e611f6@kernel.org>
 <20250224-configfs-v4-3-9af9b5e611f6@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi Andreas,

> On 24 Feb 2025, at 10:21, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> Add a sample to the samples folder, demonstrating the intended use of =
the
> rust configfs API.

nit: this is not the first time I see Rust not capitalized in this =
series.

>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> samples/rust/Kconfig          |  11 +++
> samples/rust/Makefile         |   1 +
> samples/rust/rust_configfs.rs | 179 =
++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 191 insertions(+)
>=20
> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> index 918dbead2c0b..2f97bf9a7b4c 100644
> --- a/samples/rust/Kconfig
> +++ b/samples/rust/Kconfig
> @@ -10,6 +10,17 @@ menuconfig SAMPLES_RUST
>=20
> if SAMPLES_RUST
>=20
> +config SAMPLE_RUST_CONFIGFS
> + tristate "Configfs sample"
> + depends on CONFIGFS_FS
> + help
> +  This option builds the Rust configfs sample.
> +
> +  To compile this as a module, choose M here:
> +  the module will be called rust_configfs.
> +
> +  If unsure, say N.
> +
> config SAMPLE_RUST_MINIMAL
> tristate "Minimal"
> help
> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> index 5a8ab0df0567..72122f010caf 100644
> --- a/samples/rust/Makefile
> +++ b/samples/rust/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_SAMPLE_RUST_MISC_DEVICE) +=3D =
rust_misc_device.o
> obj-$(CONFIG_SAMPLE_RUST_PRINT) +=3D rust_print.o
> obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI) +=3D rust_driver_pci.o
> obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM) +=3D rust_driver_platform.o
> +obj-$(CONFIG_SAMPLE_RUST_CONFIGFS) +=3D rust_configfs.o
>=20
> rust_print-y :=3D rust_print_main.o rust_print_events.o
>=20
> diff --git a/samples/rust/rust_configfs.rs =
b/samples/rust/rust_configfs.rs
> new file mode 100644
> index 000000000000..36a2c848a979
> --- /dev/null
> +++ b/samples/rust/rust_configfs.rs
> @@ -0,0 +1,179 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Rust configfs sample.
> +
> +use kernel::alloc::flags;
> +use kernel::c_str;
> +use kernel::configfs;
> +use kernel::configfs_attrs;
> +use kernel::new_mutex;
> +use kernel::page::PAGE_SIZE;
> +use kernel::prelude::*;
> +use kernel::sync::Mutex;
> +
> +module! {
> +    type: RustConfigfs,
> +    name: "rust_configfs",
> +    author: "Rust for Linux Contributors",
> +    description: "Rust configfs sample",
> +    license: "GPL",
> +}
> +
> +#[pin_data]
> +struct RustConfigfs {
> +    #[pin]
> +    config: configfs::Subsystem<Configuration>,
> +}
> +
> +#[pin_data]
> +struct Configuration {
> +    message: &'static CStr,
> +    #[pin]
> +    bar: Mutex<(KBox<[u8; PAGE_SIZE]>, usize)>,
> +}
> +
> +impl Configuration {
> +    fn new() -> impl PinInit<Self, Error> {
> +        try_pin_init!(Self {
> +            message: c_str!("Hello World\n"),
> +            bar <- new_mutex!((KBox::new([0; PAGE_SIZE], =
flags::GFP_KERNEL)?, 0)),
> +        })
> +    }
> +}
> +
> +impl kernel::InPlaceModule for RustConfigfs {
> +    fn init(_module: &'static ThisModule) -> impl PinInit<Self, =
Error> {
> +        pr_info!("Rust configfs sample (init)\n");
> +
> +        let item_type =3D configfs_attrs! {
> +            container: configfs::Subsystem<Configuration>,
> +            data: Configuration,
> +            child: Child,
> +            attributes: [
> +                message: 0,
> +                bar: 1,
> +            ],
> +        };

As I said in the previous patch, this macro is a bit complex. Is there =
anything more you can do with it?

If so, it better be in this driver, because I hardly think anybody will =
go through the source code itself
to figure out. My 2c.


> +
> +        try_pin_init!(Self {
> +            config <- configfs::Subsystem::new(
> +                c_str!("rust_configfs"), item_type, =
Configuration::new()
> +            ),
> +        })
> +    }
> +}
> +
> +#[vtable]
> +impl configfs::GroupOperations for Configuration {
> +    type Child =3D Child;
> +
> +    fn make_group(&self, name: &CStr) -> Result<impl =
PinInit<configfs::Group<Child>, Error>> {
> +        let tpe =3D configfs_attrs! {
> +            container: configfs::Group<Child>,
> +            data: Child,
> +            child: GrandChild,
> +            attributes: [
> +                baz: 0,
> +            ],
> +        };
> +
> +        Ok(configfs::Group::new(name.try_into()?, tpe, Child::new()))
> +    }
> +}
> +
> +#[vtable]
> +impl configfs::AttributeOperations<0> for Configuration {
> +    type Data =3D Configuration;
> +
> +    fn show(container: &Configuration, page: &mut [u8; PAGE_SIZE]) -> =
Result<usize> {
> +        pr_info!("Show message\n");
> +        let data =3D container.message;
> +        page[0..data.len()].copy_from_slice(data);
> +        Ok(data.len())
> +    }
> +}
> +
> +#[vtable]
> +impl configfs::AttributeOperations<1> for Configuration {
> +    type Data =3D Configuration;
> +
> +    fn show(container: &Configuration, page: &mut [u8; PAGE_SIZE]) -> =
Result<usize> {
> +        pr_info!("Show bar\n");
> +        let guard =3D container.bar.lock();
> +        let data =3D guard.0.as_slice();
> +        let len =3D guard.1;
> +        page[0..len].copy_from_slice(&data[0..len]);
> +        Ok(len)
> +    }
> +
> +    fn store(container: &Configuration, page: &[u8]) -> Result {
> +        pr_info!("Store bar\n");
> +        let mut guard =3D container.bar.lock();
> +        guard.0[0..page.len()].copy_from_slice(page);
> +        guard.1 =3D page.len();
> +        Ok(())
> +    }
> +}
> +
> +#[pin_data]
> +struct Child {}

nit: you don=E2=80=99t need the braces here

> +
> +impl Child {
> +    fn new() -> impl PinInit<Self, Error> {
> +        try_pin_init!(Self {})
> +    }
> +}
> +
> +#[vtable]
> +impl configfs::GroupOperations for Child {
> +    type Child =3D GrandChild;
> +
> +    fn make_group(&self, name: &CStr) -> Result<impl =
PinInit<configfs::Group<GrandChild>, Error>> {
> +        let tpe =3D configfs_attrs! {
> +            container: configfs::Group<GrandChild>,
> +            data: GrandChild,
> +            attributes: [
> +                gc: 0,
> +            ],
> +        };
> +
> +        Ok(configfs::Group::new(
> +            name.try_into()?,
> +            tpe,
> +            GrandChild::new(),
> +        ))
> +    }
> +}
> +
> +#[vtable]
> +impl configfs::AttributeOperations<0> for Child {
> +    type Data =3D Child;
> +
> +    fn show(_container: &Child, page: &mut [u8; PAGE_SIZE]) -> =
Result<usize> {
> +        pr_info!("Show baz\n");
> +        let data =3D c"Hello Baz\n".to_bytes();
> +        page[0..data.len()].copy_from_slice(data);
> +        Ok(data.len())
> +    }
> +}
> +
> +#[pin_data]
> +struct GrandChild {}

=E2=80=A6nor here

> +
> +impl GrandChild {
> +    fn new() -> impl PinInit<Self, Error> {
> +        try_pin_init!(Self {})
> +    }
> +}
> +
> +#[vtable]
> +impl configfs::AttributeOperations<0> for GrandChild {
> +    type Data =3D GrandChild;
> +
> +    fn show(_container: &GrandChild, page: &mut [u8; PAGE_SIZE]) -> =
Result<usize> {
> +        pr_info!("Show baz\n");

As I said in the cover letter, perhaps this one slip through :)

> +        let data =3D c"Hello GC\n".to_bytes();
> +        page[0..data.len()].copy_from_slice(data);
> +        Ok(data.len())
> +    }
> +}
>=20
> --=20
> 2.47.0
>=20
>=20

I=E2=80=99m OK with this patch. It works, and it does what it=E2=80=99s =
supposed to do, i.e.: showcase the API.

With the =E2=80=9CShow baz=E2=80=9D nit fixed:

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


