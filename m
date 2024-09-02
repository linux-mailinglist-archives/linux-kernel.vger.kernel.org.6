Return-Path: <linux-kernel+bounces-310723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E147496806B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E43B282865
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC2B1862BB;
	Mon,  2 Sep 2024 07:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpCC68db"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451E61862AE;
	Mon,  2 Sep 2024 07:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261506; cv=none; b=bgBB6AyPRRAw987vL4nJS1jCZXDLC2b0PHn0Ok6+ewTB5gyEQ9hW0FA2O7UebnMBo1SIBoVelKtXnu4/pmr1z9f+FI3wSP+RkMzS/navCDcp4zXnyzP7ZlUDbhowS3JMtXblQiyNDFx9mmG7ZhFQkxw1BMbnv1oU407q2l//wQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261506; c=relaxed/simple;
	bh=t3O+Haqt881Ky7t8Rj0Jw62sr6ssAiXOVQAeAImmuM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ncqe8aHRZqNLNAMUcJn10AP98b5FZreeLBgYf7aCQ+8MUU6xlMZxhL5/3rtiOdvcBNzjhgrej3qC4aY5Q5DsyYSU4AnGOFWflKVm28L4OlzFklTzSjWgqzSujt3TmtxiHeXbq0TH/OAZM3mqS+Y7Wurf+GFS37Y7x3e0wLIbp54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpCC68db; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE09C4CEC2;
	Mon,  2 Sep 2024 07:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261506;
	bh=t3O+Haqt881Ky7t8Rj0Jw62sr6ssAiXOVQAeAImmuM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EpCC68dbEmo2/+mIi/v055ItB5z6LNlBLnJBCFvX1IB5+DhCZRV9T/S6cyYy3AsxD
	 tSS9g80IH0mbbTkU158+fsH7rLIKR2/dzEiP9Em9dvzU2HCiUrB1YL3aNs28CB6yPa
	 J61SFJvYYRg6fOLUDYdpuPTTot/isZ8ntfBXNHc5Twjt8xZpC7NaHdlDD8isVYPl+C
	 zJWSU4656qXw7zfBTdjfB5peXcAfdCMIuoWSSCAJmOAOiGhbFKys4s1kBkK6cJFsTP
	 olJ8NDXKlrvkybnTnKkgvkbCWL/ypXgkRbu83en+NCmq8NlxBLaJUabOn0I1693o2h
	 xY+62Ka8cPcmA==
Date: Mon, 2 Sep 2024 09:18:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yu-Chun Lin <eleanor15x@gmail.com>
Cc: laurent.pinchart@ideasonboard.com, thierry.reding@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	visitorckw@gmail.com
Subject: Re: [PATCH] docs: devicetree: Fix typo in lvds.yaml
Message-ID: <n6rbeaomxoey5acg7jyxcclg3z7p7ucxlxzflpizq2j4cktqep@o35wquc7ioav>
References: <20240901133046.962263-1-eleanor15x@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240901133046.962263-1-eleanor15x@gmail.com>

On Sun, Sep 01, 2024 at 09:30:46PM +0800, Yu-Chun Lin wrote:
> Corrected the spelling in the description of LVDS Display Common
> Properties.
> 
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> ---
>  Documentation/devicetree/bindings/display/lvds.yaml | 2 +-

Replacing one typo in one place is a churn. Fix several typos.

You engaged three people to review this, so three people spent their
time on reviewing and answering this trivial stuff.

Please use subject prefixes matching the subsystem. You can get them for
example with  on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

Best regards,
Krzysztof


