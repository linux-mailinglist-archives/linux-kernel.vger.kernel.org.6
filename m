Return-Path: <linux-kernel+bounces-224364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0286D912164
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C48AB222B4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CB816F859;
	Fri, 21 Jun 2024 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bzvy2pqo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D792B16E860;
	Fri, 21 Jun 2024 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718963902; cv=none; b=u/n46H9Gs78A2bVcFQOyUnT3ZhdgX/HrT5NdFsXycoKxq29m2d4Ch+Fkzs4zgr77umagO7oZvqnBJiy9M8GftUhGBXWn2K8JoqIFKClnb6YTMYby9l4nWi8prc7K+hgsjgil8jebLp0Tb9ljrtOhPeXyOQ71XOBnJXH4cHHqoYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718963902; c=relaxed/simple;
	bh=z/LbWUG8PN/+nd9chQu6nk4tHqqo9e2avsANo7Qgbbk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ayrk6Fx97VZeu4DtVQaJ1MdmTCkKw9oZJFk5y/nabAbv1wdMzYP/CnxakILIs27YFToau/EqM5tywPaRpJCw4FQqEveQrRbQI0iJ+iUFY6s3a3N7CZSsH5COTTknPDmDRwSJCMHgAqieR84a6nQmvXfMzTeQAIBG110OLhr8iLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bzvy2pqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8631CC4AF08;
	Fri, 21 Jun 2024 09:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718963902;
	bh=z/LbWUG8PN/+nd9chQu6nk4tHqqo9e2avsANo7Qgbbk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Bzvy2pqo03Yn44ZgIp3NWRX2iX8neBjmGv5HTZgtCa6H3aFRkdM1TNoc4O3cZ9FsQ
	 y7zJu6i+e1RwmEK7bq1skSF5fGVCxPlA/LcX0BS+2XjNRWXwYSEY2Mj3u7IBxoWD1p
	 eEiWXeZewipu35ZPK4gryZa05gaac4q2Y8RE1Cnd9Voo0QyKz7zYoHqZcZhMGAexPO
	 jhdCFOD9beIenp6XreUBKvV1qKWQrHiY6e1bRwpRddOjKYl3QcQUbAfNssYrBGhszH
	 zAUYsxGdlF6H/W07eIhIBaJHHWlqt/IXtwKIL+t7oL4XTYBM0s3lRxq/zz6L7Tye2W
	 eD1nsc+i4KIkQ==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20240617121318.14037-1-yung-chuan.liao@linux.intel.com>
References: <20240617121318.14037-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: Intel: clarify Copyright information
Message-Id: <171896390012.263874.12654799775665202624.b4-ty@kernel.org>
Date: Fri, 21 Jun 2024 15:28:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 17 Jun 2024 20:13:18 +0800, Bard Liao wrote:
> For some reason a number of files included the "All rights reserved"
> statement. Good old copy-paste made sure this mistake proliferated.
> 
> Remove the "All rights reserved" in all Intel-copyright to align with
> internal guidance.
> 
> 
> [...]

Applied, thanks!

[1/1] soundwire: Intel: clarify Copyright information
      commit: b96f16bdf58dae08d841536820269c6b0d9c976b

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


