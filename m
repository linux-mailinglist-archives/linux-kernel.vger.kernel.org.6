Return-Path: <linux-kernel+bounces-387554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC3A9B52CF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D19B22FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304FB20721C;
	Tue, 29 Oct 2024 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WF44hvjf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EB1190486;
	Tue, 29 Oct 2024 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730230546; cv=none; b=FZ9QW7UjzpbM6ZnaVg49zUMZVVoTJmhoN8p2RHuNOaTvxs+4yGuvLKA3vtISuJlfxfgD1dNcAym6ZTPrtbUhjhgpNNyDZOssdM9ZlIxY6VIIHtTg9aKNo3rfJTbOJewzoJj4GhjaYGXfstNkhd5U4+wGkgABgzPBlho7tdhGUa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730230546; c=relaxed/simple;
	bh=5KQbaA+O7BsA/JA0J1T6fbaSAGxHI5cW1PQ5/cTrGuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eb099/7UlCLanjHlJXf9QsvM+KTa9hlu7RpdMT283kf6jTM0MQ1CSSBHbO+fysJ0Gnrk5JC7gEcyJaDIbyuP6OIaod+HB2fMzzwPbjKQnq6f1ob48Jxy86kjbnjTxki8nfYxU6Oh2qwqcFgQ7vDKNbjx5Egkc+h/Bcc8bxT1Hc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WF44hvjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B52BC4CECD;
	Tue, 29 Oct 2024 19:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730230546;
	bh=5KQbaA+O7BsA/JA0J1T6fbaSAGxHI5cW1PQ5/cTrGuY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WF44hvjfVsOy9QH0lokqppbf52+iVfI4qe+h0ERxoOQpWnFl5wtUniBjt9TS0am7z
	 TjM1JlOPueujGXP5g6til6XH9RIHmPeRwnSXyYNSe2H/wElFIpSsGPtG0DGEa5xKmv
	 sGw3nb4sv2l9cKB+DiJEFKwIlbVopxiag95TtOzSvLgGCpYbduP2pREgoSZITayFO0
	 MnQww53c+BYB4iLRmSjY4aL9h9p3lc488tOKVBNlb2BkdX4AiW/hTEICV2nc7ylaJu
	 rV6D34Xd162dixrhEjKO3s/aDeg4bbxnsVXkKDa3YP73kOZA3QadFHplTZlujJGvD5
	 jO6HdLJp1v1jA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so5174562e87.3;
        Tue, 29 Oct 2024 12:35:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgieVhC+tB0c9qjMaf+XVnY7E2vwmLyEqqx+9oLhwve9xfyCZZxaeiaqKyVP4qdy7aPTOOzhDzr259uJDW5yA=@vger.kernel.org, AJvYcCVS2sZ/qZh1KjiGdz4PA/UmWN/ijXCbwWHL1nS6l6UyuGZBMLfRDOF2IrQQTf7L154o4f5tedSY3Yd+i5ge@vger.kernel.org, AJvYcCXXkEYPv9FGB4LEqa3VI4LHooe4Oen3REGJfTCctW/ltc6coCHvrmplhbS0sJNlNfW3aGebuur4oRWC@vger.kernel.org
X-Gm-Message-State: AOJu0YxQLzohTqvA+RK5yewyecUqWPR6HbKsF07h/1b2ljaaXg9lq7MN
	aZhkXG6rDd5GaopJxR8a2ziRrfvisCWTTguavOWugkm+lgmazD193uRUwWXce9e1djNqV8oD5uS
	YCFkTtfdhHn8ySXCLY+B/RamnxA==
X-Google-Smtp-Source: AGHT+IFe9PFqt+n8Vs6QpequE7rsrw365RDFEY3bYDcLHyZ8EyQZTv5AB4GWHhbd1GDB4ZBkz78jJbxqGvlOMrcJxas=
X-Received: by 2002:a05:6512:3f1c:b0:539:e761:c21a with SMTP id
 2adb3069b0e04-53b34a365c7mr7068570e87.48.1730230543434; Tue, 29 Oct 2024
 12:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
 <20241025-rust-platform-dev-v1-2-0df8dcf7c20b@kernel.org> <CAH5fLgjhiLUYPgTt_Ks+L-zhWaQG5-Yjm-Y3tfh2b2+PzT=bLg@mail.gmail.com>
 <CAL_JsqJWPR-Q=vsxSvD7V9_v=+om5mRuW9yYNqfavVRUwH9JFw@mail.gmail.com>
 <CAH5fLgiXPZqKpWSSNdx-Ww-E9h2tOLcF3_8Y4C_JQ0eU8EMwFw@mail.gmail.com> <CANiq72kaidDJ=81+kibMNr9jNxg467HjOm9C_4G7WRvaiddGvg@mail.gmail.com>
In-Reply-To: <CANiq72kaidDJ=81+kibMNr9jNxg467HjOm9C_4G7WRvaiddGvg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 29 Oct 2024 14:35:29 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+T6T_3p2C62U3v4aSjm_oc-Ycjxi_ckF0ufh=JJDz=rg@mail.gmail.com>
Message-ID: <CAL_Jsq+T6T_3p2C62U3v4aSjm_oc-Ycjxi_ckF0ufh=JJDz=rg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] rust: Add bindings for device properties
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Saravana Kannan <saravanak@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Dirk Behme <dirk.behme@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 1:57=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Oct 29, 2024 at 7:48=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > One option is to define a trait for integers:

Yeah, but that doesn't feel like something I should do here. I imagine
other things might need the same thing. Perhaps the bindings for
readb/readw/readl for example. And essentially the crate:num already
has the trait I need. Shouldn't the kernel mirror that? I recall
seeing some topic of including crates in the kernel?

> +1, one more thing to consider is whether it makes sense to define a
> DT-only trait that holds all the types that can be a device property
> (like `bool` too, not just the `Integer`s).
>
> Then we can avoid e.g. `property_read_bool` and simply do it in `property=
_read`.

Is there no way to say must have traitA or traitB?

Rob

