Return-Path: <linux-kernel+bounces-539128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 628E2A4A144
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBC33BC7BB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88C526FDB1;
	Fri, 28 Feb 2025 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJcLPUJr"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE3D1F4C97;
	Fri, 28 Feb 2025 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740766673; cv=none; b=G7VuF8H2DiQ1khIgYDnP8zkfONawGaMr5WaN6KTVXqtLgZAnqy7K7oggPGO6DlsHmLB+SvQMyESX6x/UM/YrnPiItOmAsPV9gYYFffC0FBMbzrgi9PYj9umLL+JHFMDPM7iK8i73Zx61/lQQ7z+ICFSQmjvpv8dgnIA66/cXPGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740766673; c=relaxed/simple;
	bh=8AofP2F4EDYWcSdQf7pAjNgf76uefeOoQvXxsGf0SbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nk1K8iQBO32Jc9NvOveh0aoPbAjVoACIZavLHpBhy/tDddakYMy/OoGgBBJiM+CBwPi0kCC7xSEwpgoTYlOrXT2m9pOxwJ5/UdkzzBO61eaDz2B4BAvvSPEIViW2Vpa9iV1gF3KUXjgGMIWYsuqKOVSCDgsJLTXBxyTmKQ6Hkk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJcLPUJr; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7be8f281714so301212085a.1;
        Fri, 28 Feb 2025 10:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740766671; x=1741371471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnO2Cagq/o/4RQbZHmvvxn2F1Qoz85DXuAUAjGEYTEY=;
        b=JJcLPUJr4eiaKyHutC9nNy92mcXiFaXcqUc/Al5QQemJkPPeVWmX1Xk4f6Jct785UW
         l1yvq0vxOCiW5pMVmjEDxPJ9kfs7zIQqsOp8lhmhuxJOsDBIruN4/7O6z24oreZXQTt+
         lhiNfgqI4khLdT3FMSGlhlzxSj0t9Hqe3CAIMSKh77NQs+RYoW1ODYm9y/RSrG34Sk1e
         bHslvbp8hjVIYhsCFsuoGtgLgrCKGuItvkYO8PsVjpuQgTcJvu//d9CWRaAd56pQxcKa
         sFEbKiGldbGhZzNTvODswdZt+8ABEZzhTqHs1caEQuUCOJwjSvE/toPCKzFa7WqMpIOX
         IehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740766671; x=1741371471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnO2Cagq/o/4RQbZHmvvxn2F1Qoz85DXuAUAjGEYTEY=;
        b=JdreuKMiHf0OCnFIfmV4pKE0iJy2vAz15bLuu0DYHiv2TxdUhQUhwWy6hPVzY+lNC6
         X40EMzxOzhypZ4MziWI3vFwSkuvAF32Nhi+/rk8YNUEe9HDRXtQOtfnCnuZKDq27pGRG
         QtyhrhbzJ88UJk1yuTkNLplL/Loy1GisksMm2jZ9eDSfE5PhK6rQOdGAaHHA/bsR2DZ6
         CQiJWWqSTJwVdJKqfa3nlwSaOkP7bnWXG/3ytl0aaK9HJv1vMP+kcMJbWcawh/iUVaJG
         CHT6zMNz5XFcPgHtQ0KuzFGKJcqv/xbpcrvgacVZmJMsGRZKxlqA4kOtEcCOzjvvqhQ+
         yK2g==
X-Forwarded-Encrypted: i=1; AJvYcCUFCJgM8JNebjCTmrwSC3+AleUg9XOTXHaqIeYEr1tv/l+u8rZDt94jlhbG78HNbmV16SNvkL6rcVF8c0tC6ws=@vger.kernel.org, AJvYcCWfgFi+JQqF6zr+gsk2mW044CqQlEGK67/lT9tyHIFrRd0e7FxKlSWk1sWwynGENI3N9KLWv/l0DjabwNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXS604FeLtgthjzEVLttvZgMOV+0f9fVyWEd063H3RDMVOoETg
	+K6dxlwGi/13DuacSklBk0Sf1kLfwVXdG3KFZqypEhqNdnOrkLzX
X-Gm-Gg: ASbGncsm+ShfkUXdPY9N6dRZfjTUekwsajEW3m0mjFN6GT/UEF/dFdv+xW95WEKfmYz
	1Kg/qi8bvJvXH83evDapuXa9gsh5WjaslCee1zyqTnLOrmyjmKXBTRw8KrOn2MGBRmtcsldGw4r
	rsRFdlXzQ35VI4RWGWW6cQ1JPes8p50SYWvbISD0n0EiSs9xCZKiUZ26dNbmv4ZysCiGwekmWAs
	YpqgUkU28PmMsT93XG3ogpct3vstmV4MdbgXwKCaDL5xD8OVSF5rBNP0X6OAR1qPL/XgbDAPhFD
	V/GfhgjGxbOCEW86nLOAu8bWnVSeBnpBuFEltrsP5ARehBEr6Nbyw6HCpseMPbukTa6svsRIUAo
	LGBjNSQlSdaiFO9FE
X-Google-Smtp-Source: AGHT+IHkGTVO9Fd1unuJRA5hRhsWsecE/1hIfsm5clN6n55gNQjDnlm1Ih3jBSaVWhYfS9KWwhfs6g==
X-Received: by 2002:a05:620a:f04:b0:7c0:c829:262e with SMTP id af79cd13be357-7c39c4ce5e8mr654825285a.28.1740766670762;
        Fri, 28 Feb 2025 10:17:50 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897653667sm24744206d6.32.2025.02.28.10.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 10:17:48 -0800 (PST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2BCAC1200043;
	Fri, 28 Feb 2025 13:17:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 28 Feb 2025 13:17:48 -0500
X-ME-Sender: <xms:zP3BZ-mWgCCC33-sSfNsrUlGKORiTjjtVmgm9Qb90wZG80rTljgdLw>
    <xme:zP3BZ12zF9Mzv4m-Bjnp2RqXczI5dATadPePDI0rrVfS0UsD_EZ4zYENfI50TLwon
    oRGue00urpQe-OmlQ>
X-ME-Received: <xmr:zP3BZ8pEWSOTkUdfLD1GeOAjednkLExb3CugWtVSgR4XPFtHEUtGzvAbr98>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeluddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepieegudejffeggfduveekueelhedvuddvvddu
    keejjedufeeuhfekgfeuhffgtefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpph
    htrhdrrghsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghe
    dtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhes
    fhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepohhlihhvvghrrdhmrghnghholhgusehpmhdrmhgvpdhrtghpthht
    oheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvug
    grsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpth
    htohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohep
    sggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtoheprghlihgtvg
    hrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuhhmihgt
    hhdrvgguuh
X-ME-Proxy: <xmx:zP3BZyky6xs12jaDf7pBy_3GIGuD_GpIfb62x_h89onLOBabRDPAVg>
    <xmx:zP3BZ831RDrd3TD2KhdJotFyTAKpvIzjqD3wUZa7sgWSKWE0FJHqUg>
    <xmx:zP3BZ5tyFaSLUIEzLQVj55pMMJ0Hm2aZMhIMcBdqRVxQa9qtbLXhOg>
    <xmx:zP3BZ4WfmqUhR2JKwlkGwluQmFMptmdjueYLTjibHvza0JfBhDYPCg>
    <xmx:zP3BZ302dNuV5eZlPOu_NFd16wNYCmGvMX9KA3tlW5zI_gF9Rk0AGBPT>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 13:17:47 -0500 (EST)
Date: Fri, 28 Feb 2025 10:16:57 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] rust: adding UniqueRefCounted and UniqueRef types
Message-ID: <Z8H9mecdXoH1czSF@boqun-archlinux>
References: <EiaQ-C0o3GMQQpw3jCnXUnNgph2WIJ5-Cm8P5N9OysIlDKYrjHNun5Ol4Q1FfVGw64k6TGCfUVBJK5r0_2eypg==@protonmail.internalid>
 <Z8H6EUy1HqLrzytE@laptop>
 <Z8H7xx6_rIFTyV5V@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8H7xx6_rIFTyV5V@boqun-archlinux>

On Fri, Feb 28, 2025 at 10:09:11AM -0800, Boqun Feng wrote:
> On Fri, Feb 28, 2025 at 06:01:55PM +0000, Oliver Mangold wrote:
> > For usage with block-mq, a variant of ARef
> > which is guaranteed to be unique would be useful.
> > As chances are it is useful in general, This implements it
> > as kernel::types::UniqueRef.
> > The difference between ARef and UniqueRef
> > is basically the same as between Arc and UniqueArc.
> > 
> 
> Please add the "# Examples" section as I requested:
> 
> 	https://lore.kernel.org/rust-for-linux/Z8HcHVtPiG-X6ujP@Mac.home/
> 

More particularly, I gave an example here:

	https://lore.kernel.org/rust-for-linux/Z8HikJloVjoZXBbc@Mac.home/	

maybe I wasn't clear, sorry about that. I meant to say you need to
include the examples with the introduction of the API, and that provides
us the sample code and the tests at the first day of the new API.

Regards,
Boqun

> I also would like to know why do you think it's OK to ignore my previous
> comment, thanks!
> 
> Regards,
> Boqun
> 
> > Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> > ---
> >  rust/kernel/types.rs | 153 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 153 insertions(+)
> > 
> > diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> > index 55ddd50e8aaa..72a973d9e1c7 100644
> > --- a/rust/kernel/types.rs
> > +++ b/rust/kernel/types.rs
> > @@ -543,6 +543,12 @@ fn from(b: &T) -> Self {
> >      }
> >  }
> >  
> > +impl<T: UniqueRefCounted> From<UniqueRef<T>> for ARef<T> {
> > +    fn from(b: UniqueRef<T>) -> Self {
> > +        UniqueRefCounted::unique_to_shared(b)
> > +    }
> > +}
> > +
> >  impl<T: AlwaysRefCounted> Drop for ARef<T> {
> >      fn drop(&mut self) {
> >          // SAFETY: The type invariants guarantee that the `ARef` owns the reference we're about to
> > @@ -551,6 +557,153 @@ fn drop(&mut self) {
> >      }
> >  }
> >  
> > +/// Types that are [`AlwaysRefCounted`] and can be safely converted to an [`UniqueRef`]
> > +///
> > +/// # Safety
> > +///
> > +/// Implementers must ensure that the methods of the trait
> > +/// change the reference count of the underlying object such that:
> > +/// - the uniqueness invariant is upheld, i.e. it is not possible
> > +///   to obtain another reference by any means (other than through the [`UniqueRef`])
> > +///   until the [`UniqueRef`] is dropped or converted to an [`ARef`].
> > +/// - [`UniqueRefCounted::dec_ref`] correctly frees the underlying object.
> > +/// - [`UniqueRefCounted::unique_to_shared`] set the reference count to the value
> > +/// - that the returned [`ARef`] expects for an object with a single reference
> > +///   in existence.
> > +pub unsafe trait UniqueRefCounted: AlwaysRefCounted + Sized {
> > +    /// Checks if the [`ARef`] is unique and convert it
> > +    /// to an [`UniqueRef`] it that is that case.
> > +    /// Otherwise it returns again an [`ARef`] to the same
> > +    /// underlying object.
> > +    fn try_shared_to_unique(this: ARef<Self>) -> Result<UniqueRef<Self>, ARef<Self>>;
> > +    /// Converts the [`UniqueRef`] into an [`ARef`].
> > +    fn unique_to_shared(this: UniqueRef<Self>) -> ARef<Self>;
> > +    /// Decrements the reference count on the object when the [`UniqueRef`] is dropped.
> > +    ///
> > +    /// Frees the object when the count reaches zero.
> > +    ///
> > +    /// It defaults to [`AlwaysRefCounted::dec_ref`],
> > +    /// but overriding it may be useful, e.g. in case of non-standard refcounting
> > +    /// schemes.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The same safety constraints as for [`AlwaysRefCounted::dec_ref`] apply,
> > +    /// but as the reference is unique, it can be assumed that the function
> > +    /// will not be called twice. In case the default implementation is not
> > +    /// overridden, it has to be ensured that the call to [`AlwaysRefCounted::dec_ref`]
> > +    /// can be used for an [`UniqueRef`], too.
> > +    unsafe fn dec_ref(obj: NonNull<Self>) {
> > +        // SAFETY: correct by function safety requirements
> > +        unsafe { AlwaysRefCounted::dec_ref(obj) };
> > +    }
> > +}
> > +
> > +/// An unique, owned reference to an [`AlwaysRefCounted`] object.
> > +///
> > +/// It works the same ways as [`ARef`] but ensures that the reference is unique
> > +/// and thus can be dereferenced mutably.
> > +///
> > +/// # Invariants
> > +///
> > +/// - The pointer stored in `ptr` is non-null and valid for the lifetime of the [`UniqueRef`]
> > +///   instance. In particular, the [`UniqueRef`] instance owns an increment
> > +///   on the underlying object's reference count.
> > +/// - No other references to the underlying object exist while the [`UniqueRef`] is live.
> > +pub struct UniqueRef<T: UniqueRefCounted> {
> > +    ptr: NonNull<T>,
> > +    _p: PhantomData<T>,
> > +}
> > +
> > +// SAFETY: It is safe to send `UniqueRef<T>` to another thread
> > +// when the underlying `T` is `Sync` because
> > +// it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
> > +// `T` to be `Send` because any thread that has an `UniqueRef<T>` may ultimately access `T` using a
> > +// mutable reference, for example, when the reference count reaches zero and `T` is dropped.
> > +unsafe impl<T: UniqueRefCounted + Sync + Send> Send for UniqueRef<T> {}
> > +
> > +// SAFETY: It is safe to send `&UniqueRef<T>` to another thread when the underlying `T` is `Sync`
> > +// because it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally,
> > +// it needs `T` to be `Send` because any thread that has a `&UniqueRef<T>` may clone it and get an
> > +// `UniqueRef<T>` on that thread, so the thread may ultimately access `T`
> > +// using a mutable reference, for example, when the reference count reaches zero and `T` is dropped.
> > +unsafe impl<T: UniqueRefCounted + Sync + Send> Sync for UniqueRef<T> {}
> > +
> > +impl<T: UniqueRefCounted> UniqueRef<T> {
> > +    /// Creates a new instance of [`UniqueRef`].
> > +    ///
> > +    /// It takes over an increment of the reference count on the underlying object.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that the reference count is set to such a value
> > +    /// that a call to [`UniqueRefCounted::dec_ref`] will release the underlying object
> > +    /// in the way which is expected when the last reference is dropped.
> > +    /// Callers must not use the underlying object anymore --
> > +    /// it is only safe to do so via the newly created [`UniqueRef`].
> > +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
> > +        // INVARIANT: The safety requirements guarantee that the new instance now owns the
> > +        // increment on the refcount.
> > +        Self {
> > +            ptr,
> > +            _p: PhantomData,
> > +        }
> > +    }
> > +
> > +    /// Consumes the [`UniqueRef`], returning a raw pointer.
> > +    ///
> > +    /// This function does not change the refcount. After calling this function, the caller is
> > +    /// responsible for the refcount previously managed by the [`UniqueRef`].
> > +    pub fn into_raw(me: Self) -> NonNull<T> {
> > +        ManuallyDrop::new(me).ptr
> > +    }
> > +}
> > +
> > +impl<T: UniqueRefCounted> Deref for UniqueRef<T> {
> > +    type Target = T;
> > +
> > +    fn deref(&self) -> &Self::Target {
> > +        // SAFETY: The type invariants guarantee that the object is valid.
> > +        unsafe { self.ptr.as_ref() }
> > +    }
> > +}
> > +
> > +impl<T: UniqueRefCounted> DerefMut for UniqueRef<T> {
> > +    fn deref_mut(&mut self) -> &mut Self::Target {
> > +        // SAFETY: The type invariants guarantee that the object is valid.
> > +        unsafe { self.ptr.as_mut() }
> > +    }
> > +}
> > +
> > +impl<T: UniqueRefCounted> From<&T> for UniqueRef<T> {
> > +    /// Converts the [`UniqueRef`] into an [`ARef`]
> > +    /// by calling [`UniqueRefCounted::unique_to_shared`] on it.
> > +    fn from(b: &T) -> Self {
> > +        b.inc_ref();
> > +        // SAFETY: We just incremented the refcount above.
> > +        unsafe { Self::from_raw(NonNull::from(b)) }
> > +    }
> > +}
> > +
> > +impl<T: UniqueRefCounted> TryFrom<ARef<T>> for UniqueRef<T> {
> > +    type Error = ARef<T>;
> > +    /// Tries to convert the [`ARef`] to an [`UniqueRef`]
> > +    /// by calling [`UniqueRefCounted::try_shared_to_unique`].
> > +    /// In case the [`ARef`] is not unique it returns again an [`ARef`] to the same
> > +    /// underlying object.
> > +    fn try_from(b: ARef<T>) -> Result<UniqueRef<T>, Self::Error> {
> > +        UniqueRefCounted::try_shared_to_unique(b)
> > +    }
> > +}
> > +
> > +impl<T: UniqueRefCounted> Drop for UniqueRef<T> {
> > +    fn drop(&mut self) {
> > +        // SAFETY: The type invariants guarantee that the [`UniqueRef`] owns the reference
> > +        // we're about to decrement.
> > +        unsafe { UniqueRefCounted::dec_ref(self.ptr) };
> > +    }
> > +}
> > +
> >  /// A sum type that always holds either a value of type `L` or `R`.
> >  ///
> >  /// # Examples
> > -- 
> > 2.48.1
> > 
> > Best regards,
> > 
> > Oliver
> > 

