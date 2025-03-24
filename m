Return-Path: <linux-kernel+bounces-573982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D80A6DF3D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71246188639E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F34261586;
	Mon, 24 Mar 2025 16:05:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA716F06B;
	Mon, 24 Mar 2025 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832358; cv=none; b=DasXn/34LAZEqNqZoenD5KZfOFM5tit/+wS2OirgDqn0FOCGWlva/zg9sI/SYlCrl8wDihSVxCxCvXgekfxwDt3qcqw5oOVSEK7nPz/dR26CY3IUymLyF3w81TnIWQSzU66S9ik6AWdOIf4fDk1tH0u1w142nlp8yzn7k+7ajwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832358; c=relaxed/simple;
	bh=vL1/tCyN9FMgwjecz6QvgI4hFByZC2lX3OvWrZRKY3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iH0dpWtP9bWj/cKJ09LHw/QSFGCnm74x+3Psc0Wk1TNTV0+csNga8FWpwX2LSgm4zf74rsinVAEMcz/ZdTSNxo+mJGU6ikjMgByKgj4u0IJCmGfNc6+xVuF49RUtEYea99Mi8sKsYk2nVCrggRtMSpdO1+lKW8ieivJRz1G2f7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F28C4CEDD;
	Mon, 24 Mar 2025 16:05:56 +0000 (UTC)
Date: Mon, 24 Mar 2025 12:06:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: John Kacur <jkacur@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luis Goncalves <lgoncalv@redhat.com>
Subject: Re: [PATCH 1/6] rtla/osnoise: Unify params struct
Message-ID: <20250324120638.0629d4ee@gandalf.local.home>
In-Reply-To: <e6a2d061-42bf-72c0-0e40-75bbe5b1e831@redhat.com>
References: <20250320092500.101385-1-tglozar@redhat.com>
	<20250320092500.101385-2-tglozar@redhat.com>
	<e6a2d061-42bf-72c0-0e40-75bbe5b1e831@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Mar 2025 15:00:08 -0400 (EDT)
John Kacur <jkacur@redhat.com> wrote:

> > -#include "utils.h"
> >  #include "osnoise.h"
> >  
> >  struct timerlat_params {
> > --   
> 
> Reviewed-by: John Kacur <jkacur@redhat.com>

Please trim your replies. I tend to stop scrolling if there's no comment
after three page downs. But it is very annoying to have to scroll down an
entire long patch to see a single reviewed-by tag :-/

-- Steve

