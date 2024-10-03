Return-Path: <linux-kernel+bounces-349432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7EF98F5F1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE511C20C26
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621731A2569;
	Thu,  3 Oct 2024 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbTigUZ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D17224EA
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727979572; cv=none; b=cqrwNtrQPaA3RFtshM3o1sQbENj4wVYr0JmFyK3ffLpmL21H4EjvZ752wgMcCZ4aqGTUzIFS5iGwUfTc0jKT2L5eYtawOUwKV//RNuXd3QzXB6at3YXhw+J5szFsSQTk37RiqIBS94Odv1+2n3MJGUPSMKtuCb5aVyviqQ3CKDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727979572; c=relaxed/simple;
	bh=SXFcj7fs77zFoeRjfSfHY9vM3EpAM0JyGGpaAutZm6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=YebiNuY4czU/lKlpDknMZARXJUZtewQ/efcmYmIu/Uo0dlB6/RrHsLU9gT5QDuxKXQwZ7lF7W4tSyU26xzQRKyc7DL3+DKFog5osSM7tr1AiB7QgBprjRNVzPIKQ3y4M2wOqHo/89aIso7I66C3zqPzCyZa8LPqnLX/QSTNlYbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbTigUZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9126AC4CEC5;
	Thu,  3 Oct 2024 18:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727979572;
	bh=SXFcj7fs77zFoeRjfSfHY9vM3EpAM0JyGGpaAutZm6c=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=kbTigUZ4NuyAdNyryGFJGG0r+yajxK7fRvHKNc4hmwsMkM4PGNtZL1zBfEGHtsYxc
	 UGpvqxiM0afsLQhgG0YJtB6MfWrTn9RT5VE7HkNcx3H30Hhvfztzu4po+2zYWV8VEG
	 5GnrkhqO5qMRzotzeuxWeFithpIYfcwAQqNQwQBcqWAnYV6VWGp8QdNpr3KsOXss+N
	 7dQ9JA8voks+VIIoFq+3tExXLbeZriL0VQjjGwDdbJ3Y1Gp5F+RQWCCx4meDZMG70g
	 af52u0KRU5naAOxspxrDug5L5jN2ImCL9IKT+ICu+LPvAnqH2aGiq6cqo7fSSalhWh
	 6xDlzlfDk4Dlg==
Message-ID: <60863db7-026b-4554-b628-aa27055f7f03@kernel.org>
Date: Thu, 3 Oct 2024 20:19:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau/i2c: rename aux.c and aux.h to auxch.c and
 auxch.h
To: egyszeregy@freemail.hu
References: <20240603091558.35672-1-egyszeregy@freemail.hu>
From: Danilo Krummrich <dakr@kernel.org>
Cc: bskeggs@nvidia.com, kherbst@redhat.com, lyude@redhat.com,
 airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Language: en-US
In-Reply-To: <20240603091558.35672-1-egyszeregy@freemail.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/3/24 11:15 AM, egyszeregy@freemail.hu wrote:
> From: Benjamin Szőke <egyszeregy@freemail.hu>
> 
> The goal is to clean-up Linux repository from AUX file names, because
> the use of such file names is prohibited on other operating systems
> such as Windows, so the Linux repository cannot be cloned and
> edited on them.
> 
> Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>

Applied to drm-misc-next, thanks!

