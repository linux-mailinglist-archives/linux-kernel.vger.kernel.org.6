Return-Path: <linux-kernel+bounces-561261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F436A60F6B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B70C1B6310C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8861F5423;
	Fri, 14 Mar 2025 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4wLusHJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E251EDA0E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741949730; cv=none; b=sUWANzm1FxY0t83azA4reOJpRSNoKTVkzVnZWcOPOyowJni+XSiIvczr1PZ4a/05AjVAfGyg2R7Cc0ha9Z+TsNXZF9k8jurlVdYkCPCvtCuAVKxxtQaO3m2keQAWNl9C9kpjx9+AEyeUIBnNa7n+Dx3Z7hE/8PcKGng20hipbno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741949730; c=relaxed/simple;
	bh=ggykiNtAFb5++Arh9TO6G6V0zHTnTRMklbfila9VUWQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cA0se3lwQPdKk9mnNanI3pRRL6/sL77QytUK03ke8MT8Bgs4aNYoIzDANuiJYErCd0B5p6D5QaRJqvSzESBXMGtWXQwyBE5x7Dh2d5ZOitXREY8FOs1cQkWKAxle9ydIWRww0k0PSBJ8W3MaGo73CaCvpGpKx683glrr7Urfz+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4wLusHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D05C4CEE3;
	Fri, 14 Mar 2025 10:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741949729;
	bh=ggykiNtAFb5++Arh9TO6G6V0zHTnTRMklbfila9VUWQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=D4wLusHJyDuew9T5lzu6Y1wrOEfwIzZOKfVIHhnmbrTgy72m4bDRWUvczd2wXKM9L
	 jZVnSzJZHKljMEM1owOZhRo5vIxMSezIHuSgbnEJZYfA0SQRLSheOS8g2PGPT0aUy3
	 q6Ux9x2O81X+oUiPHAkKWmlMucXPgav2psUdVnOMMdCsl0zYwGx48KIX4IHEfl3qsh
	 VH5+NSDztpm+arp69bQCb5mJ2R9rSWrECPMSfAZNAHPxI8ozJ2jsMpaFVmnTn0dIsa
	 0Nw5KlOstPYfeuwpRogRta/1Wdlm13KqlM06Q6PCnPUzgKTzQ51sqziPQuKcDsxmXH
	 2RFs7QjQEPpBg==
From: Lee Jones <lee@kernel.org>
To: heiko@sntech.de, lee@kernel.org, Chen Ni <nichen@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250310031145.650950-1-nichen@iscas.ac.cn>
References: <20250310031145.650950-1-nichen@iscas.ac.cn>
Subject: Re: (subset) [PATCH] mfd: Convert comma to semicolon
Message-Id: <174194972874.3974397.13415252165579791906.b4-ty@kernel.org>
Date: Fri, 14 Mar 2025 10:55:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Mon, 10 Mar 2025 11:11:45 +0800, Chen Ni wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> [...]

Applied, thanks!

[1/1] mfd: Convert comma to semicolon
      commit: f82718251e302fd6321224d6c3be969245d5a2d2

--
Lee Jones [李琼斯]


