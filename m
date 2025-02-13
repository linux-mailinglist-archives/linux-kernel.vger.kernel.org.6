Return-Path: <linux-kernel+bounces-513449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF14A34A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8AE01895478
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EF026FA5B;
	Thu, 13 Feb 2025 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMSbx/Wi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A7324BC1D;
	Thu, 13 Feb 2025 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464206; cv=none; b=MM4qGUjXeDDwLxvWW89oiEi48d92zJT1eSK6HZcNvaJS6Q7AlL9W7Si9ohjQ53x1+8FUP54qwDijBltlop3JIaVlEBpByVqVGrcS25/V83ZjzSJhv0ZPKMs8KJubMYAJQOnKyA6TBNGWVsx4Xf4oa+pYlJI66E8uVLczol9gU9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464206; c=relaxed/simple;
	bh=SC+lAll5Fluj1mVmh66LeQmEtzwjo/90oZJB0wQkWIA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JbnFIzHvC888ciPtnle5U1oU+eKvlL6heZhLuG3TPQk2g+8YZgdlrYWU01vr4KmaEjbfv2uKvTjJUakDkmMXKiynfmp3SOueA0j0akxayuEeR0tILl9EEgfXnpAGa3Aekm0OhAAmzUynsb8ecoGoRlIb/AFtemmVZH0fNQUPNHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMSbx/Wi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E0FC4CED1;
	Thu, 13 Feb 2025 16:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739464205;
	bh=SC+lAll5Fluj1mVmh66LeQmEtzwjo/90oZJB0wQkWIA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gMSbx/Wi9ekPdTraDbDSLzE/3MQqS3hmdBgrsqo3Sw/Duu30Zq4JLrgCFgi78DaN5
	 by/0HQ5PMKg1qKgxrKQSBu4rra5GN/z7TobdzjEJjjKvEWfUFy3VHtZUAIEJExddeL
	 XOxVIonH2PbOxXPSmxS60cTV8ZQf49nKeYKTwF19bK/uhM4Mrz4ZNcqjrKnEuWboGZ
	 TkRPELvRYLd40zWq/oZo3lYNfFi8oAKVqODzolIbxjO/hUwMjVfUFwrFWkwyRke2s6
	 ohNwKJcm7CywX7vZ3vbNiY6IjkEKlT6Lt9N2JakYIfosxJ4CjK1SyWUMt2axjla+D1
	 zPvktC+Sv0jzw==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.dev, bard.liao@intel.com
In-Reply-To: <20250205074232.87537-1-yung-chuan.liao@linux.intel.com>
References: <20250205074232.87537-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 0/2] soundwire: Intel: support more then 1 sdw bus
 clock frequency
Message-Id: <173946420383.270661.12605891898374994214.b4-ty@kernel.org>
Date: Thu, 13 Feb 2025 22:00:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 05 Feb 2025 15:42:30 +0800, Bard Liao wrote:
> This series set frame shape and divider based on actual clk freq to
> support dynamic clock change. The revert the commit that limits Intel
> platform to use fixed clock frequency.
> 
> Bard Liao (2):
>   soundwire: cadence_master: set frame shape and divider based on actual
>     clk freq
>   Revert "soundwire: intel_auxdevice: start the bus at default
>     frequency"
> 
> [...]

Applied, thanks!

[1/2] soundwire: cadence_master: set frame shape and divider based on actual clk freq
      commit: e738d77f78b3ac085dfb51be414e93464abba7ec
[2/2] Revert "soundwire: intel_auxdevice: start the bus at default frequency"
      commit: d38ea972da679f223ae1e761080e37dd8b582bac

Best regards,
-- 
~Vinod



