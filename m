Return-Path: <linux-kernel+bounces-409913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1895C9C933B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95341F226AE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8881ABEC7;
	Thu, 14 Nov 2024 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8/7ZThB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5AA18C930;
	Thu, 14 Nov 2024 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731616080; cv=none; b=PV/QHesM79y8ZkNhJVw1pBuB3vnFRwaVTF2l52rftvyjBXcax6sib9ulrUfI8rH83ytZ5cfRmNdawhZ5ix+o6UKoOVlN7s9c+fWAEGXGyZS/jDpATCQEHHEmMFOS03KG+5a7sQ9yPlw1pHrrmouiHSx5Pz5xdRrOsZsst5AMScU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731616080; c=relaxed/simple;
	bh=npLoLJoAPPsZYqUWMpHUst1wrbIpESWfDtFjjjAbU+8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=CffQLY0eGuQkYR6bMQD5wxl981xyZiGccScCwrUG8HU6QfaGC5xiZamxQSWbbMtaewseoI13LMbmQ5+7XpiHwkMH62G67VWtAkhw1mmQVEKLOoJ0EjbhQsXtVvP1z876NIWotO6/ZO/UupP7sGHdUFNgvTTR6QFlImQ5BawFKuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8/7ZThB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D361C4CECD;
	Thu, 14 Nov 2024 20:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731616080;
	bh=npLoLJoAPPsZYqUWMpHUst1wrbIpESWfDtFjjjAbU+8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=f8/7ZThBui4dd7ly9b/K+mT8be48ezcJJS2qWByfGvCM4ertgejTdw9hiLn0BR6Ig
	 Iz9Cep47Ho5vQm8xrnyHoyrdYIKIYd23wfKoaRjYx9bTzE5bC8i3XHGGpSZP/HWQBf
	 b80+MMtvLdoGNIRrtxrSnEEsyjgcjystJDDLXeo/o1FkxyzVD3vDR7FyeSHpM7zJyk
	 vCLd4gUC/V4wsr3VtELYnz31enaQRDbALi8t2PF6QWPplI3PqXL+MlAOPwwZ5+3QMl
	 Q12XY6uNUBvf4fIZKACtR3XCuSNIG+OcIalrz3AuyRt2d2/kkcCc+xZH5FbQvoKfy0
	 mT5MDnwdoTe+A==
Message-ID: <f3f028f62ddc376f9a8cd504faffac82.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241114072601.265011-1-ivo.ivanov.ivanov1@gmail.com>
References: <20241114072601.265011-1-ivo.ivanov.ivanov1@gmail.com>
Subject: Re: [PATCH v4] dt-bindings: clock: actions,owl-cmu: convert to YAML
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
To: Andreas =?utf-8?q?F=C3=A4rber?= <afaerber@suse.de>, Conor Dooley <conor+dt@kernel.org>, Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>
Date: Thu, 14 Nov 2024 12:27:58 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Ivaylo Ivanov (2024-11-13 23:26:00)
> Convert the Actions Semi Owl CMU bindings to DT schema.
>=20
> Changes during conversion:
>  - Since all Actions Semi Owl SoCs utilize the internal low frequency
>    oscillator as a parent for some clocks, require it.
>=20
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Applied to clk-next

