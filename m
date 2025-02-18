Return-Path: <linux-kernel+bounces-518766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1EBA3942E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE843B43EB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F2C1E0E13;
	Tue, 18 Feb 2025 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qgiEGb/M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587271F63D5;
	Tue, 18 Feb 2025 07:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739865123; cv=none; b=UnoCp/ym6Jum+3x0YJDdWMSZpTkvcNAqNCqpLP7SQSqlMhl5Jz8fv1kgcjTctKBAUlly6JwBn1rqjucXdwJtmybW/1oN+tfDga8HmhDA0z3z3CiX16CEQR6kX3EbYmtU7E+wDshy0SDuK+ZtxhR18+ncP7rzdZbkXBWpWXfttpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739865123; c=relaxed/simple;
	bh=2/aWANcBeUbHhvbT5hHbV5p+r7RwhuBZhG3oLaTW254=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdv0SuJq5c/C6SpNWBKNa4uxJt+cLTdKXT1ADWkKw0X+/+aLiZrnPUa6WF5/d41YLDmn0BKeKa9/DZkzex7pkxKctyCs3vNjWojp2rQ9llQxqvS8MFsMnuU82FTsi3c6yq+xqp/5BKssZz5RlC24Kuq9pVEOtyldd5G1UI/sLEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qgiEGb/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A839C4CEE2;
	Tue, 18 Feb 2025 07:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739865122;
	bh=2/aWANcBeUbHhvbT5hHbV5p+r7RwhuBZhG3oLaTW254=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qgiEGb/MgOl0fWuHErNUS+uA13FQ0GgxQCVlaQJMPNRQmW55U3gk1mJHDGb0ytUL/
	 ALINEWWT/72iqHrgIxz07omre80gX5FcCtg6NmXDL+IEVMeNkbftBwn7lDfdkwhSrP
	 N6V56bkn6ma7mBLMzQoZPjU0NLANFAm7Rc3lKd+s=
Date: Tue, 18 Feb 2025 08:51:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ravi Kumar kairi <kumarkairiravi@gmail.com>
Cc: dpenkler@gmail.com, kuba@kernel.org, dan.carpenter@linaro.org,
	rmk+kernel@armlinux.org.uk, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] staging:gpib:agilent_82350b.c: cleaned commented
 out code
Message-ID: <2025021856-unrented-property-c111@gregkh>
References: <20250217195050.117167-1-kumarkairiravi@gmail.com>
 <20250217195050.117167-3-kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217195050.117167-3-kumarkairiravi@gmail.com>

On Tue, Feb 18, 2025 at 01:20:49AM +0530, Ravi Kumar kairi wrote:
> From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> 
> cleaned code that was commented out and cleaned blank line that resulted
> from cleaning out commented code
> 
> Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> ---
>  .../staging/gpib/agilent_82350b/agilent_82350b.c   | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
> index 5a74a22015..af1bf6e893 100644
> --- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
> +++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
> @@ -176,8 +176,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
>  
>  	event_status = read_and_clear_event_status(board);
>  
> -	//pr_info("ag_ac_wr: event status 0x%x tms state 0x%lx\n", event_status, tms_priv->state);
> -
>  #ifdef EXPERIMENTAL
>  	pr_info("ag_ac_wr: wait for previous BO to complete if any\n");
>  	retval = wait_event_interruptible(board->wait,
> @@ -190,14 +188,11 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
>  		return retval;
>  #endif
>  
> -	//pr_info("ag_ac_wr: sending first byte\n");
>  	retval = agilent_82350b_write(board, buffer, 1, 0, &num_bytes);
>  	*bytes_written += num_bytes;
>  	if (retval < 0)
>  		return retval;
>  
> -	//pr_info("ag_ac_wr: %ld bytes eoi %d tms state 0x%lx\n",length, send_eoi, tms_priv->state);
> -
>  	write_byte(tms_priv, tms_priv->imr0_bits & ~HR_BOIE, IMR0);
>  	for (i = 1; i < fifotransferlength;) {
>  		clear_bit(WRITE_READY_BN, &tms_priv->state);
> @@ -210,12 +205,8 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
>  		}
>  		writeb(ENABLE_TI_TO_SRAM, a_priv->gpib_base + SRAM_ACCESS_CONTROL_REG);
>  
> -		//pr_info("ag_ac_wr: send block: %d bytes tms 0x%lx\n", block_size,
> -		// tms_priv->state);
> -
>  		if (agilent_82350b_fifo_is_halted(a_priv)) {
>  			writeb(RESTART_STREAM_BIT, a_priv->gpib_base + STREAM_STATUS_REG);
> -			//	pr_info("ag_ac_wr: needed restart\n");
>  		}
>  
>  		retval = wait_event_interruptible(board->wait,
> @@ -226,7 +217,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
>  						  test_bit(TIMO_NUM, &board->status));
>  		writeb(0, a_priv->gpib_base + SRAM_ACCESS_CONTROL_REG);
>  		num_bytes = block_size - read_transfer_counter(a_priv);
> -		//pr_info("ag_ac_wr: sent  %ld bytes tms 0x%lx\n", num_bytes, tms_priv->state);
>  
>  		*bytes_written += num_bytes;
>  		retval = translate_wait_return_value(board, retval);
> @@ -238,9 +228,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
>  		return retval;
>  
>  	if (send_eoi) {
> -		//pr_info("ag_ac_wr: sending last byte with eoi byte no:   %d\n",
> -		// fifotransferlength+1);
> -
>  		retval = agilent_82350b_write(board, buffer + fifotransferlength, 1, send_eoi,
>  					      &num_bytes);
>  		*bytes_written += num_bytes;
> @@ -284,7 +271,6 @@ static irqreturn_t agilent_82350b_interrupt(int irq, void *arg)
>  		tms9914_interrupt_have_status(board, &a_priv->tms9914_priv, tms9914_status1,
>  					      tms9914_status2);
>  	}
> -//pr_info("event_status=0x%x s1 %x s2 %x\n", event_status,tms9914_status1,tms9914_status2);
>  //write-clear status bits
>  	if (event_status & (BUFFER_END_STATUS_BIT | TERM_COUNT_STATUS_BIT)) {
>  		writeb(event_status & (BUFFER_END_STATUS_BIT | TERM_COUNT_STATUS_BIT),
> -- 
> 2.48.1
> 
>


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

