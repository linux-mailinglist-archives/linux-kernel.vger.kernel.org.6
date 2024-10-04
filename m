Return-Path: <linux-kernel+bounces-349932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DDE98FD85
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4C29B21C8C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 06:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D44413210D;
	Fri,  4 Oct 2024 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPDR8jeN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6981526281;
	Fri,  4 Oct 2024 06:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728024600; cv=none; b=sI4Ta5Gyos8q/MOV5DsEdfsAEIYmRq/J8kja/PO/0dlF4LQ3/septSQW6QvkkNi9+V4yb6Qku9kTxZyX0k95htF4iAd/IOPTW7mGxIMreZYHcjgmux2gz8yiCSiqe+mH6ncIAC7EGbNKA3HuE/jJgKMcP/Ca3NeQC9zlCxO+PgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728024600; c=relaxed/simple;
	bh=VOqP5E6Tioh6u3CoENQ+NHPj/qN6JJtlF2Bo9C7N1Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5QawTEu4hDGaPh8sNSzRbNx552Nx5sVFdkTiUOGVGYiAThejxKQWFXmji/L02SFlVeIy3byMWeOgF0+1KnTHUwPyaC01JwXfCBr6wTXOX/05fBMto9hHzwOI6rUSvgcMYOZTb56FMRwnkcRNI+hp/XD5bHHkG+Lgr+kSV+tA78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPDR8jeN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3485AC4AF09;
	Fri,  4 Oct 2024 06:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728024600;
	bh=VOqP5E6Tioh6u3CoENQ+NHPj/qN6JJtlF2Bo9C7N1Fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CPDR8jeNJ8JqGaEwpjEVRqpnwRX6Ka5dJC9Z5UcFRKaYylCeewQuTQvOZ43ONnqL4
	 Jw269BDPwGEpxn976xGSFEgEWIpmi96VT+twtUCW/1hbb+o3Qd5KiNNIyKlTsUtgn7
	 HlNm+lfZVJCKbM4XZ24klE7u6UkDOxpJmXP/QznjUayVsoiPKqnXniVg+vddcdfeNr
	 BWlaP0ta4ifJbtzheJCVbLQ8DKUXRjZgNwQmMkZ8kAcQn27R2vlubtQBewD8dE7CcN
	 nNt5oGaKgbDdIT7NgQcB+v+qxBkl9OXQ5pe9PPcfz7EpnrqBTWMEqrAH7uFwxGvQK6
	 qIdltBo2HX+OA==
Date: Fri, 4 Oct 2024 08:49:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, William Zhang <william.zhang@broadcom.com>, 
	Anand Gore <anand.gore@broadcom.com>, Kursad Oney <kursad.oney@broadcom.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm64: bcmbca: Add Zyxel EX3510-B based
 on BCM4906
Message-ID: <3okd7byomwmo5vjsyaaxsorhn6ldw3mp3k6whcklqnw2stx5tm@jpv2e5ydswzw>
References: <20241003220820.1345048-1-CFSworks@gmail.com>
 <20241003220820.1345048-2-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241003220820.1345048-2-CFSworks@gmail.com>

On Thu, Oct 03, 2024 at 03:08:19PM -0700, Sam Edwards wrote:
> This is a series (EX3510-B0 and EX3510-B1) of residential gateways based
> on BCM4906, a stripped-down version of the BCM4908 SoC. Although Zyxel's
> marketing materials call this a "series," the EX3510-B1 appears to be a
> very minor revision of the EX3510-B0, with only changes that are
> transparent to software. As far as Linux is concerned, this "series"
> effectively represents a single model.
> 
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>

Can you use the same email as for SoB?

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


