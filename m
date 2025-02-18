Return-Path: <linux-kernel+bounces-520548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDC6A3AB5A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CF7B7A43EB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBCC1D63E8;
	Tue, 18 Feb 2025 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W08e2gcd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EC21BBBD3;
	Tue, 18 Feb 2025 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739915502; cv=none; b=oLz/9zVeNYVFdKgMlceJFEheEHQ0UG4Gcu5La67P9hV9BAtCn7US8m0byXydmbaYTPwQm43CEnlcqa2nAv0EI9P8oqmcdVtU29YTUpe1ZJmGcZruvYh9J4xmRq3dJqT6nkexZvOoI6UZEUcNMLm3Z864BLbJaVIcb4UhIrTIYWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739915502; c=relaxed/simple;
	bh=W13jQITpujW99mQ7CPujO6pRt/8mwf2HQ7ShicruSHs=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=FTs/8NvmhC/O6VaU3pwbArd99MfeIMDFiu7QNgUc5nS/EVtPTQfN7NNFHSd+1d25IftxuoBIneZd341Kkia6ed5VWuvpI17KwjtiABvl1eIjhB6lawVHy6GpgNjeN9o8zaKWP+LZFy5MpHR2TBrK+CGnhZDWEU417Wzbl7ilRhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W08e2gcd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D399C4CEE2;
	Tue, 18 Feb 2025 21:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739915500;
	bh=W13jQITpujW99mQ7CPujO6pRt/8mwf2HQ7ShicruSHs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=W08e2gcdbMf1I/pADbgBXU+fDN0+fmoJr4ahb7ZKPp/Z7RIT3Fnx6kR/1D2NjgClJ
	 QoARg1qgHpPMgXZw2cDNnixm9k/hzDCITbrbKLJmHpxv6Y+ssxPi2iFxjY+AWq9Kbp
	 09y42E/YuATKOO04iYI2KnW2qWI+YFYtddwxVymXq0LITojbkglYhoQy0blo/JhTID
	 hMdz8DOV0bt/hqGIsIKAO+0jxMUPj7yx/6VsLJErGpopgXmYxyAYAXYaLi6l2oeDWS
	 9qB2//jKPCLHE/HBVV6+4l/IveguLtykXKqoM7WnZdTcL4DO8ISN29UxMY9XRHD7um
	 w9IjAIOItLWsQ==
Message-ID: <b2b9216c7c28e5eed267b9a39c8dcfb1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250218-poplar-iron-c894fe8deca6@spud>
References: <20250217-b4-k230-clk-v4-0-5a95a3458691@zohomail.com> <20250218-poplar-iron-c894fe8deca6@spud>
Subject: Re: [PATCH v4 0/3] riscv: canaan: Add support for K230-Canmv clock
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Samuel Holland <samuel.holland@sifive.com>, Troy Mitchell <TroyMitchell988@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Conor Dooley <conor@kernel.org>, Xukai Wang <kingxukai@zohomail.com>
Date: Tue, 18 Feb 2025 13:51:38 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Conor Dooley (2025-02-18 09:02:32)
> Stephen,
>=20
> Is the driver in this series satisfactory to you? If it is, can I send
> you a PR containing it and the binding so that I can apply the final
> patch in the series (and merge the basic support for the k230 soc)?
>=20

Sorry, the driver is not ready.

