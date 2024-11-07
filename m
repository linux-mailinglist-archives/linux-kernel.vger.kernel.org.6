Return-Path: <linux-kernel+bounces-400428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC859C0D6A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12536282F23
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF0B216443;
	Thu,  7 Nov 2024 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+9MZL1a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9688374CB
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731002445; cv=none; b=tpjnEYysSZTyxLlMKaHeCHpbypEgtVaU53V7D9JMykg93WlD46KwivcLRW7jSsRbmR9l0eUZ+V2zFgjSYj5WoLM3kBSRVzzEIpZ/QDENHUhp1/uKvwVz+69iYmHQUEAhZqh+wBvHsyqBj9kPo+O5BTBXrlD8fck1qP8rdaNOlKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731002445; c=relaxed/simple;
	bh=/DC9HL02bjlwGh6SD2ghissMjoxebsvomr6ylS/2bx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rmwitao2qsqphypkpqD+7DrtaueIie+4EnqW5dH3LgngGz6JBlp5+oXClZ9BxS4DzKQ7Qlshvm7B4Ixx1Lrtyk21XnW8yHG8wV6cpgPUTGZcX8hnfoXTHQWHV8u7NubrkzQME3sFNIWZKAxw3BkV+F5IFNOooR8XcisVyRtmwWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+9MZL1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D47FC4CECC;
	Thu,  7 Nov 2024 18:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731002445;
	bh=/DC9HL02bjlwGh6SD2ghissMjoxebsvomr6ylS/2bx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=f+9MZL1aAbhC4pbKK2/eRBGcFLno8p6YLBrcPxk1eg7otXkR/xE+vGjlQbDnhynyx
	 7KEwKVu6aY+7gOJgzD/rmcPa/t2nJo9AoMWubzR1JE24zzxoHrtsXOG4ze216ZleQ/
	 9nmhJKC6h/Ugw9N/rxMhMW4Rvrz9tE1UnU8YYxVDGLhGfb2K1S3LMgekfA3x3N83w6
	 /5csqzcnmHuy0tQUOXZUq036+6QNdXy0zGI2MWEXMbBH1SJgUmx3lO3wa9f7cORr78
	 wXhaP8W9qlTB5ZwtBMjlwGvM81aYooLy977j4RAXJMq1bl130GihjylEK5KtcvYB72
	 XJz4ImfCYueow==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: pratyush@kernel.org,  mwalle@kernel.org,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: winbond: add "w/ and w/o SFDP" comment
In-Reply-To: <20241029080049.96679-1-tudor.ambarus@linaro.org> (Tudor
	Ambarus's message of "Tue, 29 Oct 2024 08:00:49 +0000")
References: <20241029080049.96679-1-tudor.ambarus@linaro.org>
Date: Thu, 07 Nov 2024 18:00:43 +0000
Message-ID: <mafs04j4i9b5g.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 29 2024, Tudor Ambarus wrote:

> Commit d35df77707bf ("mtd: spi-nor: winbond: fix w25q128 regression")
> upstream fixed a regression for flavors of 0xef4018 flash that don't
> define SFDP tables. Add a comment on the flash definition highlighting
> that there are flavors of flashes with and without SFDP support.
> It spares developers searching the entire git log for when we'll better
> handle these cases.

Acked-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

