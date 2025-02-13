Return-Path: <linux-kernel+bounces-513711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E157A34DB9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4AA188E3BF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE8E245AEE;
	Thu, 13 Feb 2025 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u13pkGZ9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183D4245025
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471409; cv=none; b=JajB1zdM/Ng8MuZqDElxX5UOKv28z6OcAfk0rzf6sh4aNkkXl96zqi4fLIU+6mDhUhoybNN4uku7oIAFkyGUHGb5UUyxYTOa1EO2T2FZDUYUXNFUDKRbVHBT1IXtSJ/n6LQkjy9vfyOPV5OuEEA807bTRqiTo1qfVUSwBhh9vkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471409; c=relaxed/simple;
	bh=eliJd8h1lECYk4Z6oPRqZIozGBbWvzE5WksoyaLXPQE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Io978qwNQoEoQDcxWCPtARh8wMVmyL3KDuZZYEnuZNG7f6qri7XxlK5lZzUE3+Kv9dHcNmzToYx4l4Us1y2qCgYabvJrJOK/pDlhpdpuskIeqjSyl5JkHGUGN+QgfAyr8i+iOvSktpNd1y7c/HTYFDHQ3DYLWzcbnnUuShwzulY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u13pkGZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3B8C4CED1;
	Thu, 13 Feb 2025 18:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739471408;
	bh=eliJd8h1lECYk4Z6oPRqZIozGBbWvzE5WksoyaLXPQE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u13pkGZ9sO8RN6VpwsM22N2TecZo5CodhvUbxThp54NQLdc8/8Xzno7fu4pIFDWO7
	 eDuIHRU0T/CoZIU7l+GxPBiiE5Kz9yGd1qzSOXx1hb0nHh5MdV0nQUSo/AwyzyoIdx
	 nT5ob7G6lmFlxiXjZGU2i9dai+EkVidt4DXS9oGCV6TEwPTiU90BAZTVr5BsrlhVdN
	 VrFrK4/aDhwnAXmHyfZW2I15ZHlrhv3Pim5yOk9q0haOPg7u5yE2xj/VoQHR/Pj7ff
	 DiHEiVE1lPD1MDSJaGKwATH4wOJHOxJx0jrdsOn5C58mitPITfn+VkGc0/kJv0JpMD
	 vBsBuZa166rnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC8C3380CEEF;
	Thu, 13 Feb 2025 18:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Add myself as a riscv reviewer
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173947143775.1330575.11190275171918774171.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 18:30:37 +0000
References: <20241212131134.288819-1-alexghiti@rivosinc.com>
In-Reply-To: <20241212131134.288819-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 12 Dec 2024 14:11:34 +0100 you wrote:
> The goal is for me to get a kernel.org account and then send pull requests
> in order to relieve some pressure from Palmer and make our workflow
> smoother.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - MAINTAINERS: Add myself as a riscv reviewer
    https://git.kernel.org/riscv/c/967154646b7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



