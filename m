Return-Path: <linux-kernel+bounces-420167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B149D763E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29FC016520B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 16:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91CE18B494;
	Sun, 24 Nov 2024 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7C5X32D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D432500A6;
	Sun, 24 Nov 2024 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732467581; cv=none; b=H/2Enb3JOWVIqb0oFZwIu0M8LC1T3juyEqSUQza2wfu/uCfmUS7Tnk4beasRX33LzZfVMczw8HQ3ARj0vyWDwXCf9VI/U32uJf+/OupMUE/BZpwQ/kaz6OeXx7uW2hwa5mCFiOblVVwQhRbtypcvScDz0oVfQek7fblBPT0dMVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732467581; c=relaxed/simple;
	bh=62lzdX1je+3iYYAmaaDAMkNrEtuWCkBzEZG2dnkQSzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WX3htXApFA3dTYAzKIXoK0l0vf0aFGnVOrUL2UiQ6dyywDITXzMi4BK7sP7P0hSz/tYak9G1qzR4noyztQrS/rscJs5Xw2J2hiexiYISc5CFsE0h5IA49uIfC40ZSFLu76ypxLkODt4CxuIBWDZF++JgHkRxCuv+Tw1op5gW510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7C5X32D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8406FC4CECC;
	Sun, 24 Nov 2024 16:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732467580;
	bh=62lzdX1je+3iYYAmaaDAMkNrEtuWCkBzEZG2dnkQSzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7C5X32DvxvZiyA1kpANkYZKm4v7AF0QVAw92/bwWdOwtIrUu/mh8jWAysmfVGaUC
	 q2uhS+LT/5GtHVLe28GQSHH/AnOAFjrP7WejjA6ymV7jk7/c11O6fPzxdHFBThTZP9
	 Ruk+M6QTp/AmYKdg4jio1i3vj6mVOOOjt/8Ewa+vJflhnghgSglaRUL1oN2LagAhio
	 gsB4XA1dwqpThSKC7rffCQzA30Csh0YZjoS5g2OWsWC3YY7VUD18ePW+I4DBP79yNt
	 xVh0wOh/FpCF7nF8L/qAoEO5FJyC+AmftpDw4wvEP3R1pLBxg1ap1Z1tKu2IznH88p
	 HdRUxhkzmCWMA==
Date: Sun, 24 Nov 2024 11:59:39 -0500
From: Sasha Levin <sashal@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [GIT PULL] Devicetree updates for v6.13
Message-ID: <Z0NbeyTwxo-M4Lgi@sashalap>
References: <20241118210730.GA3331421-robh@kernel.org>
 <Z0NUdoG17EwuCigT@sashalap>
 <c25e6a80-f6dc-4ef9-a90d-0fa09cbbc217@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c25e6a80-f6dc-4ef9-a90d-0fa09cbbc217@linaro.org>

On Sun, Nov 24, 2024 at 05:47:33PM +0100, Krzysztof Kozlowski wrote:
>On 24/11/2024 17:29, Sasha Levin wrote:
>> Hi Rob,
>>
>> On Mon, Nov 18, 2024 at 03:07:30PM -0600, Rob Herring wrote:
>>>      of: WARN on deprecated #address-cells/#size-cells handling
>>
>> With the commit above, I've started seeing boot warnings on a few
>
>And same boards do not report problems on the next?

Looks like they do. I haven't checked it previously, but I see that we
have similar warnings on a few boards that KernelCI is testing -next on.

-- 
Thanks,
Sasha

