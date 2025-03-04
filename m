Return-Path: <linux-kernel+bounces-545473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B709CA4ED86
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E337F170691
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5520B24C06A;
	Tue,  4 Mar 2025 19:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxmRyCbI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDF52E3385;
	Tue,  4 Mar 2025 19:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116862; cv=none; b=E7VzizgJ384ti+ESD7Xahx9ay6DYwRp8+ziKC/kxsOJnCqpGzVw57mzkC5MI3NgZQOLPY7hdjbii2i7u5/gwzcXlrCSOKbnMaErz+1Y5CqoC8nQ9ijTEez0QzHkzOLmEDvCN/rxNeCorp8pmK/m9mayMAgbkS06SKWRIqm8qQhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116862; c=relaxed/simple;
	bh=0PhniFa8GHtdXz3Hb41lDuOBvw8xpGDuE72A/qcIDEI=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=o9JKnO46c7ii3DyW86twEWdzqrACB3b1TK2+LmBbfTiRxmvG2d4MZS53cPKqCNdQeG0ZTGS06r66Qgw6D9V9Tt/BwlkA3F/F84w5R9w0b+tg73vEU0kKFzW0KVTaPx9hQnOlJolrOm6oJOxfpDSBcrBzsWR8dSsvrfFG4VLGkmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxmRyCbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014BBC4CEE5;
	Tue,  4 Mar 2025 19:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741116862;
	bh=0PhniFa8GHtdXz3Hb41lDuOBvw8xpGDuE72A/qcIDEI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=BxmRyCbIP+sVdCIPPe6g96Y5dIlBdxGQa0FU25O1gOKceaLMv+GXSzdSP4pmao+oO
	 MBcINv3xhVP1vks5eaGu/w+LdwSCQ5OZJjvHhV7mK6Bu1ht1lLviB2CfkYEqe8shdl
	 gq/gD9idsvgcq84Qh8KzA6os+eMVXUmzMt6KaMxCEMWitQ2FWZVpD4pJxmyd/1U7eG
	 3DAlAyZcYw/7Beey1Z3vSunHjvRkjL1WJfzVqOSjgrSpdC2bi2uswtpnQ6W3FhpM+h
	 XEqYNNTavETHowHYhvI5R4uoJfu1+f5PX5zottflQqWAPt2/ezQ9VyVTX867+Gbn3X
	 jtju8vXvlvJkQ==
Message-ID: <efd38edbed2743a258bbec7e80ff2238.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAA8EJppgU7_BoVCDfTuKVveBnnhtHUN6jEzkUaAou7=aypD-Dw@mail.gmail.com>
References: <20250201-topic-ignore_unused_warn-v1-1-f29db78cea3a@oss.qualcomm.com> <93b5004dacfe1151ca3abbb0fa31eaa6.sboyd@kernel.org> <87241686-90b5-44fe-b4e9-1a59451e3575@broadcom.com> <CAA8EJppgU7_BoVCDfTuKVveBnnhtHUN6jEzkUaAou7=aypD-Dw@mail.gmail.com>
Subject: Re: [PATCH] clk: Warn (and therefore taint the kernel) on clk_ignore_unused
From: Stephen Boyd <sboyd@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Marijn Suijten <marijn.suijten@somainline.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Florian Fainelli <florian.fainelli@broadcom.com>
Date: Tue, 04 Mar 2025 11:34:19 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Dmitry Baryshkov (2025-03-03 15:17:21)
> On Tue, 4 Mar 2025 at 00:16, Florian Fainelli
> <florian.fainelli@broadcom.com> wrote:
> >
> > On 3/3/25 14:48, Stephen Boyd wrote:
> > > Quoting Konrad Dybcio (2025-02-01 08:52:30)
[...]
> > >>
> > >> The clock subsystem plays a crucial part in this quest, as even if
> > >> the clock controllers themselves don't draw a lot of power when on
> > >> (comparatively), improper description of clock requirements has been
> > >> the #1 cause of incomplete/incorrect devicetree bindings in my
> > >> experience.
> > >
> > > What is a user supposed to do about this warning stack? We already pr=
int
> > > a warning. I don't see us dumping the stack when a driver is unfinish=
ed
> > > and doesn't implement runtime PM to save power.
> > >
> >
> > Agreed, I don't think this is tremendously helpful given that it does
> > not even tell you what part is incomplete, it's just a broad warning for
> > the entire system.
> >
> > Assuming you have a clock provided that can be used to turn clocks off,
> > and you did not boot with 'clk_ignore_unused' set on the kernel command
> > line, then you should discover pretty quickly which driver is not
> > managing the clocks as it should no?
>=20
> Unfortunately it's sometimes not that easy. And some developers
> pretend that 'clk_ignore_unused' is a viable way to run the system.
>=20

Maybe we would be better off with a config option that removes the clk
ignore unused ability entirely. Then you can have a kernel config check
somewhere in the build process that verifies that a user can't even set
the kernel commandline to change the behavior.

