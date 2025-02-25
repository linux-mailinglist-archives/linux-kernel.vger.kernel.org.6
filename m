Return-Path: <linux-kernel+bounces-531112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E550A43C56
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC219168ACF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C8F267728;
	Tue, 25 Feb 2025 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="LIT+zWm6"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F222676FC;
	Tue, 25 Feb 2025 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480875; cv=pass; b=jLkrGb47EHV7Om2R4MQ6yJjQoKLzxHBAgwMZ2MGvu4Kgpqa+f9wmmoedoavpzEdRGH2e4KlhNVXsZDRwelfvPEOW3R1NE+aXKz0D22yl1VphxR2o4qNA50ZSlGmwSVp4U6MCA8FnjUL3LcbMYs03MzLG8084Oi7/jKWA+je51Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480875; c=relaxed/simple;
	bh=qbTxBQK2STAAGh02B53GVQzPHvRQiyjHVS3S393Qdvs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=O37WXZbsa/3VLV9iT18YiKHSWmCYmbuBx8IKDynuZKU5oMx1mZjH0C56o3iJjaaWxuM/iUmxTANC1CmS3hix7mHqVthA9d4HrV6TRDm6twBuVnIJdm65Zngco7s0nuhyCFrKhSAXH+sFtuBAzvTN/048lW7LYB0AlolugpBkjIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=LIT+zWm6; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740480820; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WGp0Fx7q8nN/yWqvuYDn/lV4iEr1dNokznjLM23+mkucd8/Ns7QuBgm1NgEo+VxaEf6yTxQZ0tQ/Py3DVN5DAdHRSpswJBBXRzp7aXiLFP3Bl9wgz4WXNNSvKqQI4SjnEEQRKeYYycIBM7rGPZr9UH/exMK45fv6qECQ0pf3sEo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740480820; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=otRZ2uz+Mlv8JdHtbYLZ+NQHbnu7uY6KivMcXcTNGpU=; 
	b=ApJ683OAhTX/0ulQLgxN0uSn0NaVGM3aZOLFJfOyvS8C68As6K8xXr135jUyGJpEqZSpveaeO4shEy3L0D5wdD1VSEPGf8tW+sZOIuBpNjqSCtK1s8siYN4JfF6ntMnIuMM7I4s4jIGo87SI3vKvhGzwT35Y2lQKTJlxDb+ldvU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740480820;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=otRZ2uz+Mlv8JdHtbYLZ+NQHbnu7uY6KivMcXcTNGpU=;
	b=LIT+zWm6o/bl/H6IrxIT5kUq/UFCmKJule28sqyYAKgjLUXf8I95mKUxpZG61F9n
	oe3Cj9h7b5iaoEqS/ulg9tSKZrTka/hpruNqWuXEYCbGEUtLZUlEn1JOTcUSL6M5M7o
	R5LxPX/GIQVnDhn1j6h0UDrKv4sWXuI3K6TsOv9s=
Received: by mx.zohomail.com with SMTPS id 1740480817176660.1971399053058;
	Tue, 25 Feb 2025 02:53:37 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH v4 2/4] rust: configfs: introduce rust support for
 configfs
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <87plj6wcz3.fsf@kernel.org>
Date: Tue, 25 Feb 2025 07:53:19 -0300
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
Message-Id: <118A2077-91B6-485F-AA5F-03D54AC5771C@collabora.com>
References: <20250224-configfs-v4-0-9af9b5e611f6@kernel.org>
 <20250224-configfs-v4-2-9af9b5e611f6@kernel.org>
 <lOoYh91-WphgZiaB1UWmZfYfG8hcG7pCydLGcO6VmeHOfZir-M4jz0KEO2AUMTkugvDLkvKw-M4Kl40xG8sgvg==@protonmail.internalid>
 <F1FA8DA8-A54D-49B1-BE8F-2B0DE14F4899@collabora.com>
 <87plj6wcz3.fsf@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External



> On 25 Feb 2025, at 07:11, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> "Daniel Almeida" <daniel.almeida@collabora.com> writes:
>=20
>> Hi Andreas,
>>=20
>>> On 24 Feb 2025, at 10:21, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>>>=20
>>> This patch adds a rust API for configfs, thus allowing rust modules =
to use
>>> configfs for configuration. The implementation is a shim on top of =
the C
>>> configfs implementation allowing safe use of the C infrastructure =
from
>>> rust.
>>>=20
>>> The patch enables the `const_mut_refs` feature on compilers before =
rustc
>>=20
>> Where?
>=20
> Not any more! It was merged with `IdArray`, and apparently it did not
> make a conflict when I rebased. I'll drop this paragraph.
>=20
> [...]
>=20
>>> +
>>> +impl<Data> Group<Data> {
>>> +    /// Create an initializer for a new group.
>>> +    ///
>>> +    /// When instantiated, the group will appear as a directory =
with the name
>>> +    /// given by `name` and it will contain attributes specified by =
`item_type`.
>>> +    pub fn new(
>>> +        name: CString,
>>=20
>> Is it me or this can be simply &CStr? `config_item_set_name` either =
copies into an internal
>> buffer or allocates, so I see no reason to pass an owned type here.
>=20
> This function returns an initializer that would be bound by the =
lifetime
> of the reference you pass in. That in turn has a very negative effect =
on
> the ergonomics of the function, as it would limit the places you can
> call it and still satisfy lifetime requirements.
>=20
> We could pass in a borrow and create an owned instance from the =
borrow,
> then move the owned value into the initializer. But I think taking an
> owned parameter in the first place is better.


Do you mean that the CString is used to guarantee that the string is =
alive when the initializer
actually runs?

If so, I did not consider that. Please disregard this comment then.

>=20
> [...]
>=20
>>> +
>>> +/// # Safety
>>> +///
>>> +/// `this` must be a valid pointer.
>>> +///
>>> +/// If `this` does not represent the root group of a `configfs` =
subsystem,
>>> +/// `this` must be a pointer to a `bindings::config_group` embedded =
in a
>>> +/// `Group<Parent>`.
>>> +///
>>> +/// Otherwise, `this` must be a pointer to a =
`bindings::config_group` that
>>> +/// is embedded in a `bindings::configfs_subsystem` that is =
embedded in a
>>> +/// `Subsystem<Parent>`.
>>> +unsafe fn get_group_data<'a, Parent>(this: *mut =
bindings::config_group) -> &'a Parent {
>>> +    // SAFETY: `this` is a valid pointer.
>>> +    let is_root =3D unsafe { (*this).cg_subsys.is_null() };
>>> +
>>> +    if !is_root {
>>> +        // SAFETY: By C API contact, `this` is a pointer to a
>>> +        // `bindings::config_group` that we passed as a return =
value in from
>>> +        // `make_group`. Such a pointer is embedded within a =
`Group<Parent>`.
>>=20
>> This phrase is confusing.
>=20
> I am not sure how to rephrase it to be less confusing. The pointer is
> the thing returned from `make_group`. `make_group` would only return a
> pointer into a `Group<Parent>`.

The problem is this: "that we passed as a return value in from=E2=80=9D, =
to pass something as a return value
is already hard to parse, and when you reach the =E2=80=9Cin from=E2=80=9D=
 part, it becomes even harder.

Just say a variation of what you said above, that is perfectly =
understandable.

What about:

```

`this` is a pointer to a `bindings::config_group` that was returned from =
a call to `make_group`. The pointer is known
to be embedded within a `Group<Parent>`.

```


>=20
>=20
> [...]
>=20
>>> +    /// # Safety
>>> +    ///
>>> +    /// If `this` does not represent the root group of a `configfs` =
subsystem,
>>> +    /// `this` must be a pointer to a `bindings::config_group` =
embedded in a
>>> +    /// `Group<Parent>`.
>>> +    ///
>>> +    /// Otherwise, `this` must be a pointer to a =
`bindings::config_group` that
>>> +    /// is embedded in a `bindings::configfs_subsystem` that is =
embedded in a
>>> +    /// `Subsystem<Parent>`.
>>> +    ///
>>> +    /// `item` must point to a `bindings::config_item` within a
>>> +    /// `bindings::config_group` within a `Group<Child>`.
>>> +    unsafe extern "C" fn drop_item(
>>> +        this: *mut bindings::config_group,
>>> +        item: *mut bindings::config_item,
>>> +    ) {
>>> +        // SAFETY: By function safety requirements of this =
function, this call
>>> +        // is safe.
>>> +        let parent_data =3D unsafe { get_group_data(this) };
>>> +
>>> +        // SAFETY: By function safety requirements, `item` is =
embedded in a
>>> +        // `config_group`.
>>> +        let c_child_group_ptr =3D
>>> +            unsafe { kernel::container_of!(item, =
bindings::config_group, cg_item) };
>>=20
>> nit: container_of is already in scope
>=20
> Thanks!
>=20
> [...]
>=20
>>> +
>>> +/// A `configfs` attribute.
>>> +///
>>> +/// An attribute appears as a file in configfs, inside a folder =
that represent
>>> +/// the group that the attribute belongs to.
>>> +#[repr(transparent)]
>>> +pub struct Attribute<const ID: u64, O, Data> {
>>=20
>> The first thing I thought here is =E2=80=9Cwhat is O?!"
>=20
> Would you prefer a rename to "Operations"? I was told to not add trait
> bounds on the struct, because it is not necessary.

I=E2=80=99d prefer Operations, yes.

>=20
>>=20
>>> +    attribute: Opaque<bindings::configfs_attribute>,
>>> +    _p: PhantomData<(O, Data)>,
>>> +}
>>> +
>>> +// SAFETY: We do not provide any operations on `Attribute`.
>>> +unsafe impl<const ID: u64, O, Data> Sync for Attribute<ID, O, Data> =
{}
>>> +
>>> +// SAFETY: Ownership of `Attribute` can safely be transferred to =
other threads.
>>> +unsafe impl<const ID: u64, O, Data> Send for Attribute<ID, O, Data> =
{}
>>> +
>>> +impl<const ID: u64, O, Data> Attribute<ID, O, Data>
>>> +where
>>> +    O: AttributeOperations<ID, Data =3D Data>,
>>=20
>> I recommend renaming =E2=80=9CO" into something that denotes this =
bound better.
>>=20
>> It can be terse as appropriate, but simply =E2=80=9CO=E2=80=9D is a =
bit *too terse* .
>=20
> Right, I agree. However, other reviewers have argued negatively about
> using 4 letters for the "Data" bound, since generic type parameters =
are
> often just single capital letters.

This is a convention, that is all. As a person trying to make sense of =
this code, Data was *much*=20
more informative than T or U, or etc. Same for `Parent`.=20

If you see things like:

```
impl<Data> Subsystem<Data>
```

You already know it=E2=80=99s a type parameter. If you click on Data, =
assuming LSP support, it will also tell
you that.

This code is already a bit hard to follow as is, let=E2=80=99s make sure =
that the types actually aid in its
comprehension and not the other way around, please.

>=20
> I will draw attention to the the Rust API guidelines[1] which allow
> `UpperCamelCase` names .
>=20
> @Benno, you had a different opinion, can you weigh in?
>=20
> [1] https://rust-lang.github.io/api-guidelines/naming.html
>=20
> [...]
>=20
>>> +    /// Create a new attribute.
>>> +    ///
>>> +    /// The attribute will appear as a file with name given by =
`name`.
>>> +    pub const fn new(name: &'static CStr) -> Self {
>>> +        Self {
>>> +            attribute: Opaque::new(bindings::configfs_attribute {
>>> +                ca_name: name as *const _ as _,
>=20
> Let's get rid of this `as _` cast.
>=20
>>> +                ca_owner: core::ptr::null_mut(),
>>> +                ca_mode: 0o660,
>>=20
>> Shouldn=E2=80=99t `ca_mode` be somehow taken as an input? Also, can =
we get rid of the literal here?
>=20
> That would be a nice addition for a follow up series.
>=20
>>=20
>>> +                show: Some(Self::show),
>>> +                store: if O::HAS_STORE {
>>> +                    Some(Self::store)
>>> +                } else {
>>> +                    None
>>> +                },
>>> +            }),
>>> +            _p: PhantomData,
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +/// Operations supported by an attribute.
>>> +///
>>> +/// Implement this trait on type and pass that type as generic =
parameter when
>>> +/// creating an [`Attribute`]. The type carrying the implementation =
serve no
>>> +/// purpose other than specifying the attribute operations.
>>> +#[vtable]
>>> +pub trait AttributeOperations<const ID: u64 =3D 0> {
>>=20
>> I assume that this ID parameter is to allow for multiple =
implementations, like we currently do
>> for the Workqueue? If so, can you mention this in the docs?
>=20
> Absolutely.
>=20
>>=20
>>> +    /// The type of the object that contains the field that is =
backing the
>>> +    /// attribute for this operation.
>>> +    type Data;
>>> +
>>> +    /// Renders the value of an attribute.
>>> +    ///
>>> +    /// This function is called by the kernel to read the value of =
an attribute.
>>> +    ///
>>> +    /// Implementations should write the rendering of the attribute =
to `page`
>>> +    /// and return the number of bytes written.
>>> +    fn show(data: &Self::Data, page: &mut [u8; PAGE_SIZE]) -> =
Result<usize>;
>>> +
>>> +    /// Stores the value of an attribute.
>>> +    ///
>>> +    /// This function is called by the kernel to update the value =
of an attribute.
>>> +    ///
>>> +    /// Implementations should parse the value from `page` and =
update internal
>>> +    /// state to reflect the parsed value.
>>> +    fn store(_data: &Self::Data, _page: &[u8]) -> Result {
>>> +        kernel::build_error!(kernel::error::VTABLE_DEFAULT_ERROR)
>>> +    }
>>> +}
>>> +
>>> +/// A list of attributes.
>>> +///
>>> +/// This type is used to construct a new [`ItemType`]. It =
represents a list of
>>> +/// [`Attribute`] that will appear in the directory representing a =
[`Group`].
>>> +/// Users should not directly instantiate this type, rather they =
should use the
>>> +/// [`kernel::configfs_attrs`] macro to declare a static set of =
attributes for a
>>> +/// group.
>>> +#[repr(transparent)]
>>> +pub struct AttributeList<const N: usize, Data>(
>>> +    UnsafeCell<[*mut kernel::ffi::c_void; N]>,
>>=20
>> For the sake of maintainability, can you provide some docs on this =
type?
>>=20
>> For example, what is the c_void here?
>=20
> As per the docstring above, is a list of `Attribute`. I can expand it =
a bit:
>=20
> /// Users should not directly instantiate this type, rather they =
should use the
> /// [`kernel::configfs_attrs`] macro to declare a static set of =
attributes for a
> /// group.
> +///
> +/// # Note
> +///
> +/// This type is constructed statically at compile time and is by the
> +/// [`kernel::configfs_attrs`] macro.
> #[repr(transparent)]
> pub struct AttributeList<const N: usize, Data>(
> +    /// Null terminated Array of pointers to `Attribute`. The type is =
`c_void`
> +    /// to conform to the C API.

Yes this is much better :)

>     UnsafeCell<[*mut kernel::ffi::c_void; N]>,
>     PhantomData<Data>,
> );
>=20
>=20
> Does that work?
>=20
>>=20
>>> +    PhantomData<Data>,
>>> +);
>>> +
>>> +// SAFETY: Ownership of `AttributeList` can safely be transferred =
to other threads.
>>> +unsafe impl<const N: usize, Data> Send for AttributeList<N, Data> =
{}
>>> +
>>> +// SAFETY: We do not provide any operations on `AttributeList` that =
need synchronization.
>>> +unsafe impl<const N: usize, Data> Sync for AttributeList<N, Data> =
{}
>>> +
>>> +impl<const N: usize, Data> AttributeList<N, Data> {
>>> +    /// # Safety
>>> +    ///
>>> +    /// This function can only be called by the `configfs_attrs`
>>> +    /// macro.
>>=20
>> Well, a pub function can be called from anywhere in the crate. Maybe =
`should` would be more
>> appropriate? I assume you want to tell people to not call this
>> directly.
>=20
> Yes, it is in the safety requirements section of an unsafe function. =
But
> you are right "can" is not the right word. I think "must" is =
appropriate.

Ack.

>=20
>> Otherwise I=E2=80=99m left wondering
>> whether there is some magic going on that I=E2=80=99m unaware of to =
make what you said possible.
>=20
> No magic, it is a prerequisite for calling, something you would have =
to
> justify in the safety comment at the call site.

Ack.

>=20
>>=20
>>> +    #[doc(hidden)]
>>> +    pub const unsafe fn new() -> Self {
>>> +        Self(UnsafeCell::new([core::ptr::null_mut(); N]), =
PhantomData)
>>> +    }
>>> +
>>> +    /// # Safety
>>> +    ///
>>> +    /// This function can only be called by the `configfs_attrs`
>>> +    /// macro.
>>> +    #[doc(hidden)]
>>> +    pub const unsafe fn add<
>>> +        const I: usize,
>>> +        const ID: u64,
>>> +        O: AttributeOperations<ID, Data =3D Data>,
>>> +    >(
>>> +        &'static self,
>>> +        attribute: &'static Attribute<ID, O, Data>,
>>> +    ) {
>>=20
>> Can you convert this into a where clause? IMHO it will be much easier =
to read, given how the
>> function args got formatted here.
>=20
> Sure. Const types cannot go in where clause, but formatting is better
> with the bound on "O" moved.

Oh, I see. My main issue here is that the formatting makes it hard to =
see that this is a function,
and that the things enclosed in parenthesis are the actual arguments. =
Our eyes really have to
scan for the `fn` token here.


>=20
> [...]
>=20
>>> +                $(
>>> +                    static [< $data:upper _TPE >]:
>>> +                        $crate::configfs::ItemType<$container, =
$data>  =3D
>>> +                            =
$crate::configfs::ItemType::<$container, $data>::
>>> +                            new_with_child_ctor::<N, $child>(
>>> +                                &THIS_MODULE, &[<$ data:upper =
_ATTRS >]
>>> +                            );
>>> +                )?
>>> +
>>> +                & [< $data:upper _TPE >]
>>> +            }
>>> +        }
>>> +    };
>>> +
>>> +}
>>=20
>> Andreas, just a suggestion for the sake of maintainability, can you =
add some docs to this macro?
>>=20
>> I think you=E2=80=99ll agree that there is a *lot* going on here.
>>=20
>> In fact, this patch is a bit complex, so kudos on making it work in a =
very simple way for the callers.
>=20
> I could write a small wall of text and do some step by step expansion =
of
> the macro. But I would rather not, since we are soon (TM) going to =
have
> `syn` and `quote`, and all this horror will go away.

Ok, your call.

>=20
> One way to help parsing this mess, is using the "expand macro" feature
> of `rust-analyzer` in an editor and looking at the expanded code.

I wonder if that can=E2=80=99t be pasted inline with the docs for a =
trivial use of the macro?

I will take the verbosity *any day* over trying to figure out what is =
going on
manually here.

Or you can wait for syn and quote, as you said, that=E2=80=99s OK.

By the way, with the somewhat limited support for rust-analyzer in the =
kernel,
I wonder whether that is in fact possible. Things are much more =
restricted for
non-Cargo projects.


>=20
>>=20
>>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>>> index 496ed32b0911..ec84653ab8c7 100644
>>> --- a/rust/kernel/lib.rs
>>> +++ b/rust/kernel/lib.rs
>>> @@ -40,6 +40,8 @@
>>> pub mod block;
>>> #[doc(hidden)]
>>> pub mod build_assert;
>>> +#[cfg(CONFIG_CONFIGFS_FS)]
>>> +pub mod configfs;
>>> pub mod cred;
>>> pub mod device;
>>> pub mod device_id;
>>>=20
>>> --
>>> 2.47.0
>>>=20
>>>=20
>>=20
>> I=E2=80=99ll probably do another pass here later, there=E2=80=99s a =
lot to unpack.
>=20
> Appreciate it! Thanks for the comments!
>=20
>=20
> Best regards,
> Andreas Hindborg

=E2=80=94 Daniel


