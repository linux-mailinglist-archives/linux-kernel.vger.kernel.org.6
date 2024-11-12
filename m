Return-Path: <linux-kernel+bounces-406148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 776319C5B79
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF2F1F231E6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95860202F70;
	Tue, 12 Nov 2024 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWPbqoxe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD702022C3;
	Tue, 12 Nov 2024 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424018; cv=none; b=a3Mg4jH4CjOrI3wUo9hWpgGEVsus9mhpxS39pCcLIBnm95WfCh2PqkiNmoUIcxekywFNLQQK1FF3mol8u7vNo6TmPwgS4qvCoGpFjxO65QEFddqSyWAULl7vZlrZmgsLVdvWAbzJ1swlc8ykTu1RqgcK6WypHlpsJva8hCdrS9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424018; c=relaxed/simple;
	bh=TqPudZhp6BvbCttVgcbaY3wu/79WYkyQXfQyO/J5FH8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y29eUIgW7Ugyg/ddxO+LPGSIkUcZrmiQxw+FgNIhaGl2vGwN7kuEX5a0AOKdO+DT63OQeufUy5A9U7JDP+g8BTgB6ywZBqtHN9fBbv8JlW6kJeJtveWKa1kXIN/lpt4LubJBTJr3Q5gmd84dm5WLjkhqQj5/Nt41sFl5Y0xYX3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWPbqoxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37D5C4CECD;
	Tue, 12 Nov 2024 15:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731424017;
	bh=TqPudZhp6BvbCttVgcbaY3wu/79WYkyQXfQyO/J5FH8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YWPbqoxecgKVCsHgwY/yMiVZI9jCmUIEA//xPcuWSUQseTLxy9ZFL6D5oATowm6Xh
	 yvYN+y8jraJjUOwO43uyi6xcG9coCycHFn7gf7u9ZrsaV2HcRCxGCuYD9dkBnYZcVV
	 JeTE9kJINgQNcU4ZZcZY81zqSPskJraztNAp0xotrITEO4LuWiVuWafLptwKGwXxtZ
	 JhUWZHM+nv9zUTVx6PGWsfHRVtVs01ZEPWy+DboD/D7XChM/11L1f000Dzz7VGFrc/
	 4V6X9jbFXxSl5jsvDMlLqFaaEpiU949cd7QwR9qDYwuvy2G1xb1yxHK7DN6MDhtvyT
	 sZc+xnp6Tzaiw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, mazziesaccount@gmail.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
Cc: sre@kernel.org
In-Reply-To: <20241111102701.358133-1-andreas@kemnade.info>
References: <20241111102701.358133-1-andreas@kemnade.info>
Subject: Re: (subset) [PATCH v2] dt-bindings: mfd: bd71828: Use charger
 resistor in mOhm instead of MOhm
Message-Id: <173142401556.1066714.6164232665290840964.b4-ty@kernel.org>
Date: Tue, 12 Nov 2024 15:06:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Mon, 11 Nov 2024 11:27:01 +0100, Andreas Kemnade wrote:
> Apparently there was some confusion regarding milliohm vs. megaohm.
> (m/M). Use microohms to be able to properly specify the charger
> resistor like other drivers do. This is not used yet by mainline code
> yet. Specify a current sense resistor in milliohms range rather then
> megaohms range in the examples.
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: bd71828: Use charger resistor in mOhm instead of MOhm
      commit: 8ece9d248b851b97e1e0779caa2ca98df9bc41f7

--
Lee Jones [李琼斯]


