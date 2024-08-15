Return-Path: <linux-kernel+bounces-288188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494DB95370F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D23289E62
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E961B1417;
	Thu, 15 Aug 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBaEpCBR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC8D1AED41;
	Thu, 15 Aug 2024 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735404; cv=none; b=NTIM4z4RNDtuJdLY4OumZLyndYNLl2Pobbr9Y6TNSLfbYv3mlgmN5jOSrm8ql1Oe69PW3TuU7yuI9VUb34biaAq30K4XJKOi7b8hhCge48Rwir5UI1r+QWu8nVF2o2jMljC1exkVWOruRbqBKOiLPbCAZtYwPozowZY6LB/sJ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735404; c=relaxed/simple;
	bh=BC2Sg/pENxiSKTGpSAGJuRuG/LZpcWMlBsMjd6YZ9Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HH3RWbuUJ8nrTc+9O089jvAx43626/fAodoKTk7cpl4xXvQKni+q8Qomjonau2f3B0ZWxFO+SCheiuDiNF5eLmHrECQLhfgLx6oaWPTRx2XGR8wBtaaxVbSmeFnfZFV1CLXE2EdFrSRjF1nw1p1r1AFd4gtrhMgq4SuL7XE8dko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBaEpCBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD16C32786;
	Thu, 15 Aug 2024 15:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723735403;
	bh=BC2Sg/pENxiSKTGpSAGJuRuG/LZpcWMlBsMjd6YZ9Fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aBaEpCBRTk1hJQWtYH029IVYFRHqoj5hYskwp32zIn+b5nGDo1LTKxpraTs1P4kKt
	 GKcMyaU8BSwk3putZd5HusvzhXdH+WYfvQDVT5nVonrM0XLoV/xe6ZqCTgFQCLifzP
	 V8BlPC3g7ZYdZLSFQF0GH7KAVbgKwECfnzpeVm0KUaOdHbYeIjrbkspjdL2y+ucjpY
	 b1JAl1xZN+uHmjz66Vv+wg7r31yM496QV9GNSafVECC5IYDfrFOrd2G32SCijbDa+O
	 v10JwtoKCQnmyO43/hjsYe8qRiIYQiNxMamxT3HhlCsgxwYwWttZkkcZJ8eSdTEMoB
	 pL+cZCfvQUxQw==
Date: Thu, 15 Aug 2024 09:23:22 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Hugues KAMBA MPIANA <hugues.kambampiana@arm.com>
Cc: krzk+dt@kernel.org, linux-kernel@vger.kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, abdellatif.elkhlifi@arm.com
Subject: Re: [PATCH v2] dt-bindings: arm: Update Corstone-1000 maintainers
Message-ID: <172373539995.1872045.4860957128183345526.robh@kernel.org>
References: <20240814133525.4090877-1-hugues.kambampiana@arm.com>
 <20240815145622.377614-1-hugues.kambampiana@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815145622.377614-1-hugues.kambampiana@arm.com>


On Thu, 15 Aug 2024 15:56:22 +0100, Hugues KAMBA MPIANA wrote:
> The previous maintainers are no longer working on the Corstone-1000.
> - Add new maintainers: Abdellatif El Khlifi, Hugues Kamba Mpiana
> - Remove maintainers: Vishnu Banavath, Rui Miguel Silva
> - Update contact information for existing maintainers
> 
> Signed-off-by: Hugues KAMBA MPIANA <hugues.kambampiana@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/arm,corstone1000.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!


