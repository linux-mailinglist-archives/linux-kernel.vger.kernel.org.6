Return-Path: <linux-kernel+bounces-418490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8612F9D622D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DBC4B240E7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD691DED6D;
	Fri, 22 Nov 2024 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Yl+NEqgD"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D24F1DE3A8;
	Fri, 22 Nov 2024 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292697; cv=pass; b=fkI3TQK8COUIHF66TBNcE0Z5FuLsq5Xu/2zZEDddGmIduM/u8zhFdeprKWoGkh0WmmBqeRCbqci64ZwThlTc0tk1d923RsyN7S0ZrpW4JVPdrSMCtX+awLK0AtHcXorzKd5QlNMaZXH1YTw3bEWtmrSXB3IxZNOTcj3l1lMUh1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292697; c=relaxed/simple;
	bh=5JxRY6pS1gCRI0YnUGZ+sjsxWOB6b+YCqATava4zccA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KY2nDbIWm0oYof0x8aNYO/pCzQdp/UAUCbHMa1sCztcW2fZyvu6jYHbcLguJZXiNtPnBEnhZx8pwZorKmXi1M1n2R9h1uTc67bOGeq6nXhdtnVdoa1khCVu6aYEAIjAgDcuIJTrgb+LlNyBqn08m74GzQZVNiKT+d1bRIbVvuJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Yl+NEqgD; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732292664; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HxoxQGkYNiq67+sV+NsTiaZff7Zg+zFHVeeikn6ZRJeph8oNg/gIkY42Mcq5ZxBF/LOYhDTyorUNrUyKDz8HcMnuUGhi9clE/2j1XZgF57jpT7bJJO+obFZWmVoZ5XwgmVfiAuNblNtuJZEUIgJxlZtqjq0qnD1CXeXLfwdrVpA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732292664; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=s4UP/Kic/pY1S+vv571Oz/mPT/MmsOkVJZEmMiRT78Y=; 
	b=cCRLEsTnxi36H7G9/COrHVIwQW7Zstk59HEuw1JDsBnoq1fJS6LQX6YRwVE34cJIV3xxq5BHkYS6e3SD0/ftMlOo/z3F/cS72LDIZz3BYwIZ0qIpLsn2xYctj27Nq5nBNdTCm5tEMkQzSiClogQIHa6grZXIIKlU8fGMNAGVTqc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732292664;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=s4UP/Kic/pY1S+vv571Oz/mPT/MmsOkVJZEmMiRT78Y=;
	b=Yl+NEqgDsE7fynFExs9ilzDRbX1sdwAq7f+cv5YimZ0L3Rv4C7bjF3g8MBL2vYbr
	0nccwe8BcXXc258SbUJhgQKN9fSjakrtTf7BVLKnH1JaMGo/efUbgl/hmIxvcaOlhfJ
	1jgwqRreu6soS06KcKbNkm5XNmw2w9t4YW1gFfNY=
Received: by mx.zohomail.com with SMTPS id 1732292662078941.2613947204142;
	Fri, 22 Nov 2024 08:24:22 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v3 04/13] rust: hrtimer: implement `TimerPointer` for
 `Arc`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CANiq72mkBufEV43HcZZVKB=1UDxOrpweFxeZJBXt6U0=vPMsdg@mail.gmail.com>
Date: Fri, 22 Nov 2024 13:24:04 -0300
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
 Lyude Paul <lyude@redhat.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4D006430-A78E-476C-BC59-AE3F2BC24584@collabora.com>
References: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
 <20241017-hrtimer-v3-v6-12-rc2-v3-4-59a75cbb44da@kernel.org>
 <25I5c2B_KkmqpaLqb6jsZyMd9WMhQbTaIKyUYY5cKa8bvR7--HvRiXJ_5cDiyde31tnivT5_C_5IJ6XvLqCusA==@protonmail.internalid>
 <73814ac7e363af44ae6e410f101feb75e94244ef.camel@redhat.com>
 <874j423p7r.fsf@kernel.org>
 <CANiq72mkBufEV43HcZZVKB=1UDxOrpweFxeZJBXt6U0=vPMsdg@mail.gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi everyone,

> On 22 Nov 2024, at 09:36, Miguel Ojeda =
<miguel.ojeda.sandonis@gmail.com> wrote:
>=20
> On Wed, Nov 20, 2024 at 4:52=E2=80=AFPM Andreas Hindborg =
<a.hindborg@kernel.org> wrote:
>>=20
>> No particular reason. It is often easier to rebase things around when
>> they are on their own line.

I do agree. You get way fewer conflicts this way.

IMHO, imports_granularity=3Ditem and group_imports=3DStdExternalCrate =
would make things
a bit more tidy.

>>=20
>> Are there any code guidelines to follow on this?
>=20
> Not yet -- we have a mixture of styles, though we typically don't go
> to the item-level like in this patch, and instead have done it closer
> to the "Crate" or "Module" styles.
>=20
> Ideally we would automate at least to some degree, but currently the
> relevant `rustfmt` options are unstable:
>=20
>    https://rust-lang.github.io/rustfmt/#imports_indent
>    https://rust-lang.github.io/rustfmt/#imports_layout
>    https://rust-lang.github.io/rustfmt/#imports_granularity
>    https://rust-lang.github.io/rustfmt/#group_imports

This is a bit unfortunate indeed.

>=20
> I agree that deciding on one style would be nice (especially if it is
> reasonable to expect that the style would be eventually supported by
> `rustfmt`).
>=20
> Cheers,
> Miguel
>=20

=E2=80=94 Daniel


