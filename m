Return-Path: <linux-kernel+bounces-449822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3D09F5697
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68EFA188028F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47641F8AF0;
	Tue, 17 Dec 2024 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwMFc97a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488331F76BE;
	Tue, 17 Dec 2024 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734461595; cv=none; b=KgKV1VrGbNZ5LHm8LhftJ460YF946b3RZIMQhjIvbgRZgY7/Aao8+SqkIQsABZ5EbqvO85J/IT5OeEbvp//l2rkWx6m1EW5gRgM6+HEXlgO1wbdH99pomyEVqpue/ly8+y9p4MuX6mV8Gq58InTYAwnLlxpeDQQ2ImMBxK74Leg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734461595; c=relaxed/simple;
	bh=6RgTZqHjU7r6mRU3DFiGShoSX50zWfvKJDzxXD+jdnk=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=MrsV6+yLBrM8dbSLvdj91u6Gd8gJZNskd6uleKe1d9XQwi0VNsHub3reGos3stf9GyJ38AAPfhHdrYSkimYHHh7FscCrSv5WtZ27LE/ImNmKULkURRO1ZeL2MguDoZoOC0qcNmtD6a35AfJ6gNK+6KEIKieGE1BwXJodNMy0BCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwMFc97a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B58AC4CED3;
	Tue, 17 Dec 2024 18:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734461594;
	bh=6RgTZqHjU7r6mRU3DFiGShoSX50zWfvKJDzxXD+jdnk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=YwMFc97a3KHMZQL+nl4u36nkjTRizldCYFEyTpwbwPkKQiW/3AjxWISWjKuXh5KNW
	 2HFMLb8zYJaG4wYBx4YCQY9osf+Moch8YMDqKQHegPpQjHHnlqq68xRzvHXu0qaHm3
	 bumdwlfbCfnsiFClRgSxaBUt1gGbIgLl8IgESZas8nrH+EAYqne+7x0eaJdsGHxoB6
	 GdWfTwEmBDhy9Vwn5DA+Hx3tIc99uISZ2KLEX9Jo9Fb7OQn3nw9dWkwNnKaGQtrdHb
	 J/wDM5adU4y+9N2Y09TFFyjdFGt2fluFc2UGR6O2rSDu24OgRc49CPNdRK9MpN14p8
	 REJDRTFmP4XOQ==
Message-ID: <431fd00e656048d474b53ee32abb7e7d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241217174154.84441-1-brgl@bgdev.pl>
References: <20241217174154.84441-1-brgl@bgdev.pl>
Subject: Re: [PATCH v2] clk: davinci: remove platform data struct
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>
Date: Tue, 17 Dec 2024 10:53:12 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Bartosz Golaszewski (2024-12-17 09:41:54)
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> There are no board files using struct davinci_pll_platform_data anymore.
> The structure itself is currently used to store a single pointer. Let's
> remove the struct definition, the header and rework the driver to not
> require the syscon regmap to be stored in probe().
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Applied to clk-next

