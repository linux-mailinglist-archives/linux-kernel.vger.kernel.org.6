Return-Path: <linux-kernel+bounces-348727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261FC98EB14
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1D5280E1F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADA213C906;
	Thu,  3 Oct 2024 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/v78EfN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B983E13B780;
	Thu,  3 Oct 2024 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727942929; cv=none; b=u5UcpJAo7d1k1ei9A2NIPvTunfIxCL+cUgF0BmKuiqceNI6qhpkAi0SsUg7CDUd3tG2KXMAQ+YOxfQrpqPqm+4zU8XSIm0jNKMH5ssJIKfJm5ltWkCMBQtLs6id6pWRgjUSFGksa1Y5qeq2Rntr0zOmxdq0yJMoCWFDmzmB5kcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727942929; c=relaxed/simple;
	bh=JQSc4Gy74IYsv6b5rvwlAPl/JwX6/yk84vSqYveWEuc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LhfO78CKZs5zNmQjmV4TWagwgidEF1rEO5H8JnyWsAgFbZmminlUSRUpgOeQhRogwIFWkYLbDsJcxYb7N52lZKUJemAXbbzw4jSmS3pEF3lOz2KGASNvrljNfT31er4wWEOP0m6OVdHJdrCHg6uYg8zA+1u3v2U8zqxKuhn2VUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/v78EfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4292C4CECD;
	Thu,  3 Oct 2024 08:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727942929;
	bh=JQSc4Gy74IYsv6b5rvwlAPl/JwX6/yk84vSqYveWEuc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=H/v78EfNnZjNKail1j5W34O35Pvi5fd2p1HO34lqnFLYUad0XMvpbQrPR87FVLAmW
	 XQCTAIxqDPOBfe3M26dXntTkZf5c7yK1TRbQCnc84ZvHH6jIuMg43aSNdXHVJG+eUI
	 6h5vvWrJRofyewIERnXANePLbvSGL1aDIB+xhCNQb5OhVpfzfScrumT+6Jf9cT3PHC
	 EAdU0lbAU6jZEeKBEbwxyXO7N7HM20dvQKbjjSUjgfEokKwEjCDNz4GYhuzuA0sics
	 qxksdisDUXeDaRG44/IeCaHomFO/RVOxK1wawrxBG6UHX9nb+2q1htDYrFJVtC7hDS
	 sbtXNZZodb7aA==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.dev, bard.liao@intel.com
In-Reply-To: <20241003070650.62787-1-yung-chuan.liao@linux.intel.com>
References: <20241003070650.62787-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH v2 RESEND 00/14] soundwire: mipi-disco: add partial
 SoundWire Disco 2.1
Message-Id: <172794292755.250995.11138295698068056449.b4-ty@kernel.org>
Date: Thu, 03 Oct 2024 13:38:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 03 Oct 2024 15:06:36 +0800, Bard Liao wrote:
> This patch series adds partial support for the SoundWire Disco 2.1.
> 
> v2:
>  - use mipi_device_property_read_bool() to get "mipi-sdw-sdca-interrupt-register-list"
> 
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> 
> [...]

Applied, thanks!

[01/14] soundwire: mipi_disco: add MIPI-specific property_read_bool() helpers
        commit: 093227bc53a023991ba04315f42839a22b613113
[02/14] soundwire: optimize sdw_stream_runtime memory layout
        commit: 444d6824a4feca142b0a57095a2f1f1bda98e2ab
[03/14] soundwire: optimize sdw_master_prop
        commit: 6cb2c156439430a7f9db2e1f71a7dccf1ca978bf
[04/14] soundwire: optimize sdw_bus structure
        commit: 0a323dad1c4e04048988cd04c60eaffd6ae61b1a
[05/14] soundwire: optimize sdw_slave_prop
        commit: 1c758df5a83ea0c9b5055536336d8a586b5010b0
[06/14] soundwire: optimize sdw_dp0_prop
        commit: 557e28f8b53243097162cf4d3e59bcee9fb9713b
[07/14] soundwire: optimize sdw_dpn_prop
        commit: 9942f90bdcc035eb5f01d7343dac99bd805ef3ec
[08/14] soundwire: mipi-disco: remove DPn audio-modes
        commit: 1ae4aa59d79399be0591c8d78c44e280406e2c34
[09/14] soundwire: mipi-disco: add error handling for property array read
        commit: a489afc105ed55f7537fb158e40d083ee57a698b
[10/14] soundwire: mipi_disco: add support for clock-scales property
        commit: 89e95be18de16ed4942bb77b639118abcd085ce4
[11/14] soundwire: mipi-disco: add support for peripheral channelprepare timeout
        commit: 4b230967c5506b1e55d4fd37722d87fb7aaa1ce7
[12/14] soundwire: mipi-disco: add comment on DP0-supported property
        commit: 1ab88b57bbc2196545a510679e01b1f26158c39b
[13/14] soundwire: mipi-disco: add new properties from 2.0 spec
        commit: 543bd28a3bfeff31f748ba83348b63313dd37ff9
[14/14] soundwire: mipi-disco: add support for DP0/DPn 'lane-list' property
        commit: 71b405b184449fffcb76ea0814104b71dfdb2aee

Best regards,
-- 
~Vinod



