Return-Path: <linux-kernel+bounces-231119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 046BE91866F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323801C21E99
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BDB18E76C;
	Wed, 26 Jun 2024 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoZDVOSy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C442DEEDD;
	Wed, 26 Jun 2024 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719417581; cv=none; b=RpidkOnRU8YB4Xfkuex1htxs2tmNET4WPbY+j7zlxdqGjZlqE3XkJdD5Mddzn+F1XBAhtKV8RX/td3Sjc8drYINSOcUUdEapD7s7a9s/Vzq9rO6GpbLY5/TM8iuZI70ilNls5zY2ESDhA9HmTzJx0i4y258wH5qGb9NCdqbFh+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719417581; c=relaxed/simple;
	bh=WkE2djDIIoqPBEGB+k2nK1H7Elli7AmT8xsMWfmMEuc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TsvGfVl1cMomQhNRmol14kqlP2G8nGN+KUJl3JrIsQtm8DwO4KDu7oY56CJfpdeATyt4SIC4kAs1oM56PXbSJtxp3IdIr/A7nktJMnKhyYZcMzckXijp2v282ORYeKfyTQU6ZXr9iKOlCaY26Z2kedr8H5rW+wds49KjUcyN+dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoZDVOSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7463AC116B1;
	Wed, 26 Jun 2024 15:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719417581;
	bh=WkE2djDIIoqPBEGB+k2nK1H7Elli7AmT8xsMWfmMEuc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AoZDVOSy9sMWEYb2aJ+MUhDAOrpi+OOZQC4lo/k+p3R5FsrLsK4VVHjQRsZhN/dph
	 J2EckG8vZ5M0VjefI7kuEct/GMbkCjQt31U/otvel6s1SxLF1FL8jfevlEptREfY5p
	 B8mQlO8gIwokzIbja8Yk5+FpV/mOVSHXHEpltpKGjezwy0ncayo3u6zIyEvQS97pIb
	 6vV/n65L5bZTyqe16IqVljbhTAiFWasKcmB8DSlteq/ecUKuQw8DQiQgSCTnWidRbw
	 8iSy04IjpYVfMdd1rUTw1Xju60BvrSu0lT7XW/L/5m7FiF+pj8L6GvbR05pE7ESDeB
	 DhSMMKm0fcpbg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20240623134600.115098-1-krzysztof.kozlowski@linaro.org>
References: <20240623134600.115098-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v2] dt-bindings: mfd: Explain lack of child
 dependency in simple-mfd
Message-Id: <171941757920.2534629.6693868138282442038.b4-ty@kernel.org>
Date: Wed, 26 Jun 2024 16:59:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Sun, 23 Jun 2024 15:46:00 +0200, Krzysztof Kozlowski wrote:
> Common mistake of usage of 'simple-mfd' compatible is a dependency of
> children on resources acquired and managed by the parent, e.g. clocks.
> Extend the simple-mfd documentation to cover this case.
> 
> 

Applied, thanks!

[1/1] dt-bindings: mfd: Explain lack of child dependency in simple-mfd
      commit: b448048dd540fa5b0176dc0bb07309887485da59

--
Lee Jones [李琼斯]


