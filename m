Return-Path: <linux-kernel+bounces-325425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC42975989
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C121B1C2313A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E071B4C4A;
	Wed, 11 Sep 2024 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmXgss2E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49831B3F36;
	Wed, 11 Sep 2024 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076159; cv=none; b=QgXRa3tRj2MGjRUc/TzU2Z93NaHmAO4werBF8qPWujrPLmr+jkTLrafb8yzSInDzayIg0N0fj/uNV+RISlhZl1k6GABP3GrIBH6Id6yNucUvnZfOT4/6NaONkrqwOle1xnxiLovvmsO/eWO46uZt1KUhC6hMIT+h7ZTMEktPZ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076159; c=relaxed/simple;
	bh=B+8kHFG6GDk8TMxMonyWxF+9E4kM8Ko6DZ6+TCyxbDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lR/RwxMjudq+zF9vXSI8gMzAp7W3E7WhKyYFf2g2l10zTVml14wf+jZ3pbANNt1AkUYTOlz3ghulUblV85M8D5c5yLjUtCQEUMwkrY/GZtex9Ax7Gj9DrXO+/24dgO4bAxNJZH9zhG3D/BvMKcTDHxyIVu3EW4E+tPKbpRuPKCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmXgss2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233EDC4CEC0;
	Wed, 11 Sep 2024 17:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726076158;
	bh=B+8kHFG6GDk8TMxMonyWxF+9E4kM8Ko6DZ6+TCyxbDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NmXgss2Eq1ibmvIciA1UjdxO9JsxoRmXSEHlh51D2P7Ma6ITV5C4wN4xG4j3dbRUK
	 RHPtwgQ+5Y358eiO47EpQObxkh9QJiN8DO3YXHMQZFYn35tDeikwYmjAykyd9Bluu/
	 drzTt1c2AEP/D5Hid5ZXpA/2H6z6gGvlT0xvGUIyAgXpDv2LphqpZ6gfsGJhxDMmle
	 Br+geBfJgWbi1P5vJHqAtiUwaSdF4InPNljKGxfZnKeNksMdRWtJVUICNNWS/vdZ77
	 JhgqfocVW7NE7jdRIO6A43o1dy6pqYVhXJhsphONfcJXT8qEp7vbs3WMvoGAZqjzMd
	 /1ZNZtkLsDOWA==
Date: Wed, 11 Sep 2024 12:35:57 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: conor+dt@kernel.org, quic_psodagud@quicinc.com, krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org, kernel@quicinc.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: arm: GIC: add ESPI and EPPI specifiers
Message-ID: <172607614907.1010907.12404098016116967831.robh@kernel.org>
References: <20240910162637.2382656-1-quic_nkela@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910162637.2382656-1-quic_nkela@quicinc.com>


On Tue, 10 Sep 2024 09:26:37 -0700, Nikunj Kela wrote:
> Extended SPI and extended PPI interrupts are in the range [0-1023] and
> [0-127] respectively, supported by GICv3.1.
> 
> Qualcomm SA8255p platform uses extended SPI for SCMI 'a2p' doorbells.
> 
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> ---
> 
> Changes in v4:
>         - Included interrupts ranges in description
> 
> Changes in v3:
>         - Removed the patch from original series[1]
> 
> Changes in v2:
>         - Modified subject line and description
>         - Added EPPI macro
> 
> [1]: https://lore.kernel.org/all/20240903220240.2594102-1-quic_nkela@quicinc.com/
> ---
>  include/dt-bindings/interrupt-controller/arm-gic.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!


