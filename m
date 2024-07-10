Return-Path: <linux-kernel+bounces-247041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D26392CA38
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954A31C225B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92DA46434;
	Wed, 10 Jul 2024 05:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkKeU+PI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1B6A47;
	Wed, 10 Jul 2024 05:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720590353; cv=none; b=g8yrazufrysOvzVe6zxlwNt83u+F7aoiS1/jvZbwEmjFyUCM+S0XHDRCkijCk0hrZ34NAKu+8cwRnjdnFS22vnWmLIWCJrTj/GFr8D2YvQ+kNeethr+naP2etrQdHg+O7gaLXg3SyOSNT47OwrT+KMFPWXBu3Gvg4jOtWmbApOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720590353; c=relaxed/simple;
	bh=hPoh2+HxqEXbXh3r8/b+Nfp0by+Py1ra0m+GU2C40mA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VMKzjuS3MO1lPafB07mSmeiWSM1lprm6y6RehaJGJbxjSHxI63qQLkYrNI9r17ZF5O3+e/VkGHKHkol2p+9j3iK5omMhjUe0Fi0SCQGtyjbThhOcR0s1HKsE7Hx2IE+3kmOxW+wfCBIMQngBvLkOuL3PuORYmLkPGS9GkrsVlaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkKeU+PI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C882C32781;
	Wed, 10 Jul 2024 05:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720590352;
	bh=hPoh2+HxqEXbXh3r8/b+Nfp0by+Py1ra0m+GU2C40mA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LkKeU+PIvCn2sVlR6DlUBVMp/RWHFBc09BdmlTNnQzbXS4364X4ynPawB13cxriLV
	 WrmHbUtB7x5Rjj5U+zDdNu/8JoePOvATAuxmB7r2YiGu2VlBkIOVSPxhROq9I3DFCp
	 7y+x2A4psyLFqALAp/X4l4SjDrTnJsYnISMtCI5cKc58cime+wFRx736Q1cOGjQD7S
	 vA173YsCBoy//mLFEU0KOzsCmm4AX3Qll8BX7n0X1Z7kidUfi3AysQv2pJro9A2lOE
	 P+dpyNlxrxHs5vczSEU14yR+7uGJasnMW5tepTNbtiaPn2BpmSSdAQ+rT+CpkBpLFZ
	 reqCDdaPlJB8g==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20240705114305.160233-1-yung-chuan.liao@linux.intel.com>
References: <20240705114305.160233-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: intel_auxdevice: add cs42l43 codec to
 wake_capable_list
Message-Id: <172059034962.363871.1480846430371524933.b4-ty@kernel.org>
Date: Wed, 10 Jul 2024 11:15:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 05 Jul 2024 11:43:05 +0000, Bard Liao wrote:
> cs42l43 has wake capability. Add it to the wake_capable_list.
> 
> 

Applied, thanks!

[1/1] soundwire: intel_auxdevice: add cs42l43 codec to wake_capable_list
      commit: fe600c8e2dc5dde62aefc73cb1cdcc5bff3dfed7

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


