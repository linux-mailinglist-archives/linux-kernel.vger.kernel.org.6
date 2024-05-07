Return-Path: <linux-kernel+bounces-172233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0338A8BEF3F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 23:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54E91F230C4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 21:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F7514B948;
	Tue,  7 May 2024 21:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/1KYOHB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247B779CF;
	Tue,  7 May 2024 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715118961; cv=none; b=MEKHmbgazCWTQKGwjuiz8BXW0aFsbbhHcy0va25LZh9cp6N1DBN39QvbNtLtcZphBspj5dgVBHbPYlFbEuLEu+iGneKXbkZEiOHsexYhqInRx3Fx4MbmSIFeF4Vw4aAZCfvpH/fbJ3PBU5crEgBKOkVnFPz198QPWobi9o064wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715118961; c=relaxed/simple;
	bh=XtgmE7RW9wlahHyLbulcXNkQOJlK51jano8uieYSx1M=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=mP2ACx+tU0s/yAmqTF3OfKIqfYkH5tUmhUyw9Wc09X1h9I3Zz0nR20CcMHAoPuY9lD5uZ5KiVZUfzLWUnL2/xmGLXRRW7q3kD3WjyPkkeN376cXGeCj1jwZRka+S8uAfnGobMS0RDpVYfk3gZv0gCQTWMGzlwlJE+7335R7bLzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/1KYOHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2EFC2BBFC;
	Tue,  7 May 2024 21:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715118960;
	bh=XtgmE7RW9wlahHyLbulcXNkQOJlK51jano8uieYSx1M=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=o/1KYOHBxv5ThCm7bKHpkGfGYlL/hc9Q1xusCkaGhRHjaKSjHSWuIlhPjNgxRc9UL
	 ijiOTEpUsUO4UjDd/cYYg3+Zzp+9BLJrlnWYFS9sxYW0tjraVo7mgp2TAwIW8XEtGN
	 fIEWXCfyD0BDL1k6f2lijsRUA5dmpitma+L1AMjbqn2jIxKAg7r4XxtbyYWvkckYl9
	 xltMhH2LiarOsObd9yP4OpakImWbs4Q+8KkWx+Enbm1ulkY2PSrpf6QRzoBGMnwXoZ
	 Z/BT8AV3zvKgIvtkJGQo0kf3HKBGGkWqdgry0FeRZYj4fhbt0UKoOsm9InY+6kSVSx
	 MqETlDTIqJLVQ==
Message-ID: <53d7ad338f4d3d8f5c6b29c5bb8f9088.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e93acd4c-20f7-4b46-bb9c-84fac451c894@app.fastmail.com>
References: <CA+G9fYuZd_ur56H8fwDSvUywopvn_b7ogprGkjEatQ7EPTLwYQ@mail.gmail.com> <11be44d3-0f32-49c6-b4ae-ba97a9f97763@app.fastmail.com> <820ddc2ec70780ae1ecd3af864dc8bd6.sboyd@kernel.org> <e93acd4c-20f7-4b46-bb9c-84fac451c894@app.fastmail.com>
Subject: Re: clkdev: report over-sized strings when creating clkdev entries
From: Stephen Boyd <sboyd@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>
To: Arnd Bergmann <arnd@arndb.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Naresh Kamboju <naresh.kamboju@linaro.org>, linux-clk <linux-clk@vger.kernel.org>, lkft-triage@lists.linaro.org, open list <linux-kernel@vger.kernel.org>
Date: Tue, 07 May 2024 14:55:58 -0700
User-Agent: alot/0.10

Quoting Arnd Bergmann (2024-05-07 13:52:59)
> On Tue, May 7, 2024, at 22:26, Stephen Boyd wrote:
> > Quoting Arnd Bergmann (2024-05-07 00:44:15)
> >> On Tue, May 7, 2024, at 09:20, Naresh Kamboju wrote:
> >> > The WinLink E850-96 board boot failed with Linux next-20240506 but t=
here
> >> > is no kernel crash log on the serial [1].
> >> >
> >> > Anders bisection results pointing to this commit,
> >> > # first bad commit:
> >> >   [4d11c62ca8d77cb1f79054844b598e0f4e92dabe]
> >> >   clkdev: report over-sized strings when creating clkdev entrie
> >> >
> >> > After reverting the above patch the boot test passed [2].
> >> >
> >> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >> >
> >
> > There are two fixes on the list: [1] and [2]. Perhaps one of those
> > resolves this?
> >
> > [1] https://lore.kernel.org/r/20240507065317.3214186-1-m.szyprowski@sam=
sung.com
> > [2] https://lore.kernel.org/r/20240507064434.3213933-1-m.szyprowski@sam=
sung.com
>=20
> My guess is that either one avoids the crash, but we actually
> want both of them since the problem is a combination of the two
> issues.
>=20
> I think we also need this one on top, to have a va_end() for
> each return() statement:

Makes sense. Hopefully Russell can fold that fix in as well, or you can
send it to the patch tracker.

