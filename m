Return-Path: <linux-kernel+bounces-383854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B649B20F8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 23:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11EE01C20E26
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 22:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF93188733;
	Sun, 27 Oct 2024 22:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cn6T7qQf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BBB17E010;
	Sun, 27 Oct 2024 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730066880; cv=none; b=BVsanCzmQD6/RgbMk0lCON5bMyHUgTakAy0LwYcjsmjSr2LAJN0SWR+P7hPH97Q/6RjDib6dzA5uS8sHlwigLvIXkOZ/hPYmFwkWyl5L2z/pD3hlBlmOZWP1eseZbqqyfwty8XRDv+txQUgpsc7dRS0mYk/Xl7B4kW5iXQ3yEkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730066880; c=relaxed/simple;
	bh=M+fOSh12DY+uXB0hOkCfy3jG4u35jWzV5295JwlSo7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emjEgGug8MGADdcq5MtbQegF7SRdjlxs8LxFtXFuYJouj3R1vx60J7mYj4A2wRjF1vAuXBGQ7oq1dzro6cJ763TkDXaAsimYasWO9vzSkA3Le7cz5qBmCZ7KZrAcfPRiBbDjaEoM8koOvAfcq8dD+LrmG/xKMqu8Adb6+8fNGCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cn6T7qQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6F7C4CEE9;
	Sun, 27 Oct 2024 22:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730066879;
	bh=M+fOSh12DY+uXB0hOkCfy3jG4u35jWzV5295JwlSo7w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cn6T7qQfR/9Su+CuRbNy6ExAmf9ypbJtK2lkhN2jjtYvW0FnV7wfZrZLtlrX5IcFR
	 QehAQqBUdWWir1hpu5LMmA/Ulq2/G7PsnhYjGrrf4+jWx6sWYVW6Ze5mso+LHZXZli
	 YEPxImFCKyrgtsOPjzjSzOyW0wYY9WivOnoExfvlMtYkdS5Uti8MX7AfKVsE9E2Kgh
	 m/ida35h1/aso5f/ABuntjp0c54gPaTfQZTiXB9ldHPiEXHAuHE7ybBKcPl2OQ0Eok
	 TEg4kdu9Jgl/3KADrTM/nqucSfE7zffJDo2VaFTFg1deFMiOQmhojg158XYFE9jX2r
	 b7m8hkye65BHg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53b1fbb8be5so3735902e87.1;
        Sun, 27 Oct 2024 15:07:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4AZxFIKmSkL/6E1in2qKweVJ78yLflNRxhwOLtS3nbChFLcN6ihIkLVZFXNnh/IN03xS4nxzUD5JVN3Q6@vger.kernel.org, AJvYcCUa4py41q1mksYL/vZ2lwPtAW+QnjIG15JbxfZls0lHJtrujYMxDsswHHZVHUxDgcaKjGUqUacBAjPDjURQW1s=@vger.kernel.org, AJvYcCW0GYsELYqRRv/zty29hxM9GAFSG/MJuxX/KJ8niugCASocApUvNDOrsRvrAzHj+Y7wtI2bQSHY4eEG@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg3eAMAG6nRjnJke3ug0RlSHyqYFPHdf+eNck9Ek26j0Ke4OaT
	bmyCpgZ2y+YepF1vlV78Qdalj/qGfgxrz3uvTFf8W4fUyMujUuCu58mK/mt/eFnHdXD5Fr+9kmE
	GvvL9jS4uSsQvDvu+mhLzmWKi0w==
X-Google-Smtp-Source: AGHT+IGzVz1+qVJIKILu1Ma9w+9AyxRZ4PZhCLFxlDC+YXiCCbqzllw4dwrJ7/Sp4wTsYMZ6ff8zbm9Jx/qpfxN2+Is=
X-Received: by 2002:a05:6512:1092:b0:539:fc50:915f with SMTP id
 2adb3069b0e04-53b236a6802mr4614391e87.2.1730066877695; Sun, 27 Oct 2024
 15:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
 <20241025-rust-platform-dev-v1-2-0df8dcf7c20b@kernel.org> <CAFRnB2WPEQaa6X6LqMk+JTxprguakNqFXvjaUGQ0QazxKH=z4Q@mail.gmail.com>
In-Reply-To: <CAFRnB2WPEQaa6X6LqMk+JTxprguakNqFXvjaUGQ0QazxKH=z4Q@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Sun, 27 Oct 2024 17:07:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJzh7dWU9gAZV_cKfi_6kOm3stbr9DdFzdse4gUYPn9Vg@mail.gmail.com>
Message-ID: <CAL_JsqJzh7dWU9gAZV_cKfi_6kOm3stbr9DdFzdse4gUYPn9Vg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] rust: Add bindings for device properties
To: Alex Gaynor <alex.gaynor@gmail.com>
Cc: Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Dirk Behme <dirk.behme@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 4:12=E2=80=AFPM Alex Gaynor <alex.gaynor@gmail.com>=
 wrote:
>
> On Fri, Oct 25, 2024 at 5:06=E2=80=AFPM Rob Herring (Arm) <robh@kernel.or=
g> wrote:
> >
> > The device property API is a firmware agnostic API for reading
> > properties from firmware (DT/ACPI) devices nodes and swnodes.
> >
> > While the C API takes a pointer to a caller allocated variable/buffer,
> > the rust API is designed to return a value and can be used in struct
> > initialization. Rust generics are also utilized to support different
> > sizes of properties (e.g. u8, u16, u32).
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> > Not sure if we need the KVec variant, but I kept it as that was my firs=
t
> > pass attempt. Most callers are filling in some value in a driver data
> > struct. Sometimes the number of elements is not known, so the caller
> > calls to get the array size, allocs the correct size buffer, and then
> > reads the property again to fill in the buffer.
> >
> > I have not implemented a wrapper for device_property_read_string(_array=
)
> > because that API is problematic for dynamic DT nodes. The API just
> > returns pointer(s) into the raw DT data. We probably need to return a
> > copy of the string(s) instead for rust.
> >
> > After property accessors, next up is child node accessors/iterators.
> > ---
> >  rust/bindings/bindings_helper.h |   1 +
> >  rust/kernel/device.rs           | 145 ++++++++++++++++++++++++++++++++=
+++++++-
> >  2 files changed, 145 insertions(+), 1 deletion(-)
> >
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_h=
elper.h
> > index 217c776615b9..65717cc20a23 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -19,6 +19,7 @@
> >  #include <linux/pci.h>
> >  #include <linux/phy.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/property.h>
> >  #include <linux/refcount.h>
> >  #include <linux/sched.h>
> >  #include <linux/slab.h>
> > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > index 0c28b1e6b004..bb66a28df890 100644
> > --- a/rust/kernel/device.rs
> > +++ b/rust/kernel/device.rs
> > @@ -5,10 +5,14 @@
> >  //! C header: [`include/linux/device.h`](srctree/include/linux/device.=
h)
> >
> >  use crate::{
> > +    alloc::KVec,
> >      bindings,
> > +    error::{to_result, Result},
> > +    prelude::*,
> > +    str::CStr,
> >      types::{ARef, Opaque},
> >  };
> > -use core::{fmt, ptr};
> > +use core::{fmt, mem::size_of, ptr};
> >
> >  #[cfg(CONFIG_PRINTK)]
> >  use crate::c_str;
> > @@ -189,6 +193,145 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::=
Arguments<'_>) {
> >              )
> >          };
> >      }
> > +
> > +    /// Returns if a firmware property `name` is true or false
> > +    pub fn property_read_bool(&self, name: &CStr) -> bool {
> > +        unsafe { bindings::device_property_present(self.as_raw(), name=
.as_ptr() as *const i8) }
> > +    }
> > +
> > +    /// Returns if a firmware string property `name` has match for `ma=
tch_str`
> > +    pub fn property_match_string(&self, name: &CStr, match_str: &CStr)=
 -> Result<usize> {
> > +        let ret =3D unsafe {
> > +            bindings::device_property_match_string(
> > +                self.as_raw(),
> > +                name.as_ptr() as *const i8,
> > +                match_str.as_ptr() as *const i8,
> > +            )
> > +        };
> > +        to_result(ret)?;
> > +        Ok(ret as usize)
> > +    }
> > +
> > +    /// Returns firmware property `name` scalar value
> > +    ///
> > +    /// Valid types are i8, u8, i16, u16, i32, u32, i64, u64
> > +    pub fn property_read<T: Copy>(&self, name: &CStr) -> Result<T> {
> > +        let mut val: [T; 1] =3D unsafe { core::mem::zeroed() };
> > +
> > +        Self::_property_read_array(&self, name, &mut val)?;
> > +        Ok(val[0])
> > +    }
> > +
>
> This, and several of the other methods are unsound, because they can
> be used to construct arbitrary types for which may not allow all bit
> patterns. You can use:
> https://rust.docs.kernel.org/kernel/types/trait.FromBytes.html as the
> bound to ensure only valid types are used.

I meant to ask a question on this. FromBytes is probably still too
permissive for what is supported in DT. I think floating point types
would be allowed which is not valid in DT (though asahi linux has some
downstream patches adding FP data support). What I really need is the
Integer trait from the num crate or some way to define the exact types
supported. I tried Into<u32>, etc., but that didn't work.

>
> Also, instead of using mem::zeroed(), you should use MaybeUnininit
> (https://doc.rust-lang.org/stable/core/mem/union.MaybeUninit.html)
> which allows you to avoid needing to zero initialize.

Okay, thanks. Being new to rust, I find this a bit complicated
compared to C (perhaps it has to be to avoid this class of bugs).
Maybe that's because this stuff seems to have been evolving some with
the kernel rust support. In any case, some examples of how (and
perhaps) to do uninitialized and zero-initialized allocations would be
helpful as both are common in the kernel.

Rob

