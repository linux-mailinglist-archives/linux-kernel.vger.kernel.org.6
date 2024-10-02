Return-Path: <linux-kernel+bounces-347644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE3B98D89D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE971F2487E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB111D1E8F;
	Wed,  2 Oct 2024 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfSfZTX/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7211D04A2
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877584; cv=none; b=ZwPlQnyHxrnYiymGC1IeGHtuYa8FRg6i26eTklS1Nc87gBRG6EHCo0hPp61suHXatlMb6NNc9Z3au7kseF8HpH7ZxhY2GqRcw78NAytPZ8Rm6RAJIsxZsxIqMM7cuGIj35H2nExcP39mrufpKKNKP175rQHM4kSUIheMk42cHFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877584; c=relaxed/simple;
	bh=xzaIWBWTjO6m/KOn8OfUPTSO5TM+2qWnvZMfvkwuWj0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o4WfsrW7RqVAJ7BMwVmuqT0R9OHJ2ZnUZawP822FSp30nZMpLusy48AO5QiRhzLsOp9A/9F3FA/syMlXOwtmRm5wkEybaoJ+M2Oob+XtVVKYzel7+wf7JzyLhdTckduVub/AO/nbnSj4uPlfWPZs/2DogxTqVLBbwj11YZlIme4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfSfZTX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF39C4CEC5;
	Wed,  2 Oct 2024 13:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727877583;
	bh=xzaIWBWTjO6m/KOn8OfUPTSO5TM+2qWnvZMfvkwuWj0=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=YfSfZTX/sRjh8xOJzoBRmUsipBP7K1mRVhX4yyAaTvhthSV7v3zybBaxMxgZNQICa
	 Z71f0hUMef3OnX5cubjW7G+8PuzDYG3Z+FfC33tB15aV40PR2jfEMISwBhYHEqQyJX
	 PmdJ44qR3K+iOipRubznCVUva1SUUFlBijkVzQheWeeS46IjQKKbu0TkUkyvp57Xy7
	 ArSBhh/ZFPU/0P9USBafquOpqxxC2oxD3/YhhFILB3fyXaZl5x72l9QpfXHTinjKyS
	 NLqMJjimFEOBKJ4CgvrWYz/mBCoB4Htg3V50qWly4dBiNU7KYtPreVGqAv19kXVRZ9
	 2uesaCAa8MXtQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240909134941.121847-1-krzysztof.kozlowski@linaro.org>
References: <20240909134941.121847-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH] mfd: palmas: Constify strings with regulator
 names
Message-Id: <172787758286.1384461.6616830443919902014.b4-ty@kernel.org>
Date: Wed, 02 Oct 2024 14:59:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Mon, 09 Sep 2024 15:49:41 +0200, Krzysztof Kozlowski wrote:
> The names of regulators are static const strings, so pointers can be made
> as pointers to const for code safety.
> 
> 

Applied, thanks!

[1/1] mfd: palmas: Constify strings with regulator names
      commit: 1b0ed9d381dd77a566efa846f7ba5df73efbb956

--
Lee Jones [李琼斯]


